import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/transaction/domain/entities/transaction_entity.dart';

abstract class TransactionRepositoryContract {
  Future<Either<String, void>> addTransaction({
    required String name,
    required double price,
    required String category,
    required DateTime createdAt,
    required String type,
    String? note,
  });

  Future<Either<String, List<TransactionEntity>>> getTransactions({int? limit});
  Future<Either<String, void>> syncTransactions();
}
