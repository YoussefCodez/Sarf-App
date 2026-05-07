import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';
import 'package:finance_tracking/features/analytics/domain/repositories/analytics_repository_contract.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_daily_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_monthly_transactions_use_case.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/get_weekly_transactions_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAnalyticsRepository implements AnalyticsRepositoryContract {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Future<Either<String, List<TransactionEntity>>> getDateRangeTransactions(
    DateTime start,
    DateTime end,
  ) async {
    startDate = start;
    endDate = end;
    return const Right(<TransactionEntity>[]);
  }
}

void main() {
  late FakeAnalyticsRepository repository;

  setUp(() {
    repository = FakeAnalyticsRepository();
  });

  group('GetDailyTransactionsUseCase', () {
    test('passes full UTC day range to repository', () async {
      final useCase = GetDailyTransactionsUseCase(repository);
      final date = DateTime.utc(2026, 5, 7, 15, 30, 20);

      await useCase(date: date);

      expect(repository.startDate, DateTime.utc(2026, 5, 7));
      expect(repository.endDate, DateTime.utc(2026, 5, 7, 23, 59, 59, 999));
    });
  });

  group('GetWeeklyTransactionsUseCase', () {
    test('passes last 7 days UTC range to repository', () async {
      final useCase = GetWeeklyTransactionsUseCase(repository);
      final date = DateTime.utc(2026, 5, 7, 15, 30, 20);

      await useCase(date: date);

      expect(repository.startDate, DateTime.utc(2026, 5, 1));
      expect(repository.endDate, DateTime.utc(2026, 5, 7, 23, 59, 59, 999));
    });
  });

  group('GetMonthlyTransactionsUseCase', () {
    test('passes last 30 days UTC range to repository', () async {
      final useCase = GetMonthlyTransactionsUseCase(repository);
      final date = DateTime.utc(2026, 5, 7, 15, 30, 20);

      await useCase(date: date);

      expect(repository.startDate, DateTime.utc(2026, 4, 8));
      expect(repository.endDate, DateTime.utc(2026, 5, 7, 23, 59, 59, 999));
    });
  });
}
