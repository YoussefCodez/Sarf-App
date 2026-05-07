import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';
import 'package:finance_tracking/features/analytics/domain/repositories/analytics_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetDailyTransactionsUseCase {
  final AnalyticsRepositoryContract _repository;

  GetDailyTransactionsUseCase(this._repository);

  Future<Either<String, List<TransactionEntity>>> call({DateTime? date}) async {
    final now = (date ?? DateTime.now()).toUtc();
    final start = DateTime.utc(now.year, now.month, now.day);
    final end = DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999);
    return _repository.getDateRangeTransactions(start, end);
  }
}
