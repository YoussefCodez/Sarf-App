import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/features/analytics/data/datasources/remote_analytics_data_source.dart';
import 'package:finance_tracking/features/analytics/domain/repositories/analytics_repository_contract.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AnalyticsRepositoryContract)
class AnalyticsRepositoryImpl implements AnalyticsRepositoryContract {
  final RemoteAnalyticsDataSource remoteDataSource;
  final SupabaseErrorHandlerService supabaseErrorHandlerService;

  AnalyticsRepositoryImpl({
    required this.remoteDataSource,
    required this.supabaseErrorHandlerService,
  });

  @override
  Future<Either<String, List<TransactionEntity>>> getDateRangeTransactions(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final transactions = await remoteDataSource.getDailyTransactions(
        start,
        end,
      );
      return Right(transactions.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(supabaseErrorHandlerService.handleError(e));
    }
  }
}
