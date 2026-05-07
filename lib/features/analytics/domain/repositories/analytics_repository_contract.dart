import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';

abstract class AnalyticsRepositoryContract {
  Future<Either<String, List<TransactionEntity>>> getDateRangeTransactions(
    DateTime start,
    DateTime end,
  );
}
