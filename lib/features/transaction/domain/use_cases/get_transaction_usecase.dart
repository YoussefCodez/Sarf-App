import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/transaction/domain/entities/transaction_entity.dart';
import 'package:finance_tracking/features/transaction/domain/repositories/transaction_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetTransactionUseCase {
  final TransactionRepositoryContract repository;

  GetTransactionUseCase({required this.repository});

  Future<Either<String, List<TransactionEntity>>> call({int? limit}) async {
    return repository.getTransactions(limit: limit);
  }
}
