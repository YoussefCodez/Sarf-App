import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/transaction/domain/repositories/transaction_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class SyncTransactionsUseCase {
  final TransactionRepositoryContract repository;

  SyncTransactionsUseCase({required this.repository});

  Future<Either<String, void>> call() async {
    return repository.syncTransactions();
  }
}
