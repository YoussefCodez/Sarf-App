import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/services/network_info_service.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/config/utils/out_put_print_util.dart';
import 'package:finance_tracking/features/transaction/data/data_source/transaction_local_data_source.dart';
import 'package:finance_tracking/features/transaction/data/data_source/transaction_remote_data_source.dart';
import 'package:finance_tracking/features/transaction/data/models/local_transaction_model.dart';
import 'package:finance_tracking/features/transaction/data/models/transaction_model.dart';
import 'package:finance_tracking/features/transaction/domain/entities/transaction_entity.dart';
import 'package:finance_tracking/features/transaction/domain/repositories/transaction_repository_contract.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: TransactionRepositoryContract)
class TransactionRepositoryImpl implements TransactionRepositoryContract {
  final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;
  final SupabaseErrorHandlerService supabaseErrorHandlerService;
  final NetworkInfo networkInfo;
  final Uuid _uuid = const Uuid();

  TransactionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.supabaseErrorHandlerService,
    required this.networkInfo,
  });

  @override
  Future<Either<String, void>> addTransaction({
    required String name,
    required double price,
    required String category,
    required DateTime createdAt,
    required String type,
    String? note,
  }) async {
    final bool isOnline = await networkInfo.isConnected;
    final String userId = remoteDataSource.getUserId();
    final String transactionId = _uuid.v4();

    final model = TransactionModel(
      id: isOnline ? '' : transactionId,
      userId: userId,
      name: name,
      price: price,
      category: category,
      createdAt: createdAt,
      type: type,
      note: note,
    );

    try {
      if (isOnline) {
        await remoteDataSource.insertTransaction(data: model);
        await localDataSource.saveTransactions([
          model.toLocalModel().copyWith(syncStatus: SyncStatus.synced),
        ]);
        return const Right(null);
      } else {
        await localDataSource.saveTransactions([
          model.toLocalModel().copyWith(
            id: transactionId,
            syncStatus: SyncStatus.pending,
          ),
        ]);
        return const Right(null);
      }
    } catch (e) {
      printOutPut(e);
      await localDataSource.saveTransactions([
        model.toLocalModel().copyWith(
          id: transactionId,
          syncStatus: SyncStatus.failed,
        ),
      ]);
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }

  @override
  Future<Either<String, List<TransactionEntity>>> getTransactions({
    int? limit,
  }) async {
    try {
      final bool isOnline = await networkInfo.isConnected;
      if (isOnline) {
        final remoteResponse = await remoteDataSource.getTransactions(
          limit: limit,
        );
        final entities = remoteResponse.map((e) => e.toEntity()).toList();

        final localModels = remoteResponse
            .map(
              (e) => e.toLocalModel().copyWith(syncStatus: SyncStatus.synced),
            )
            .toList();
        await localDataSource.saveTransactions(localModels);

        return Right(entities);
      } else {
        final localResponse = await localDataSource.getTransactions(
          limit: limit,
        );
        return Right(localResponse.map((e) => e.toEntity()).toList());
      }
    } catch (e) {
      printOutPut(e);
      final localResponse = await localDataSource.getTransactions(limit: limit);
      if (localResponse.isNotEmpty) {
        return Right(localResponse.map((e) => e.toEntity()).toList());
      }
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }

  @override
  Future<Either<String, void>> syncTransactions() async {
    try {
      final transactions = await localDataSource.getTransactions();
      final pendingTransactions = transactions
          .where(
            (e) =>
                e.syncStatus == SyncStatus.pending ||
                e.syncStatus == SyncStatus.failed,
          )
          .toList();

      if (pendingTransactions.isEmpty) return const Right(null);

      final syncTasks = pendingTransactions.map((tx) async {
        try {
          await remoteDataSource.insertTransaction(data: tx.toModel());
          await localDataSource.saveTransactions([
            tx.copyWith(syncStatus: SyncStatus.synced),
          ]);
        } catch (e) {
          await localDataSource.saveTransactions([
            tx.copyWith(syncStatus: SyncStatus.failed),
          ]);
          rethrow;
        }
      });

      await Future.wait(syncTasks);
      return const Right(null);
    } catch (e) {
      printOutPut(e);
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }
}
