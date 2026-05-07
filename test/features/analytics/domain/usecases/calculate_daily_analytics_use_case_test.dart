import 'package:finance_tracking/config/const/transaction_types.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';
import 'package:finance_tracking/features/analytics/domain/usecases/calculate_daily_analytics_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CalculateDailyAnalyticsUseCase useCase;

  TransactionEntity tx({
    required String id,
    required double price,
    required String category,
    required String type,
  }) {
    return TransactionEntity(
      id: id,
      userId: 'user-1',
      name: 'transaction-$id',
      price: price,
      category: category,
      createdAt: DateTime.utc(2026, 5, 7),
      type: type,
    );
  }

  setUp(() {
    useCase = CalculateDailyAnalyticsUseCase();
  });

  test('returns zeroed analytics when transactions are empty', () {
    final result = useCase([]);

    expect(result.totalIncome, 0);
    expect(result.totalExpenses, 0);
    expect(result.highestSingleExpense, 0);
    expect(result.highestCategoryExpense, 0);
    expect(result.balance, 0);
    expect(result.mostExpensiveCategory, isEmpty);
    expect(result.categoryExpenses, isEmpty);
    expect(result.averageExpense, 0);
  });

  test('calculates income, expenses and most expensive category correctly', () {
    final transactions = <TransactionEntity>[
      tx(
        id: '1',
        price: 500,
        category: 'salary',
        type: TransactionTypes.income,
      ),
      tx(
        id: '2',
        price: 120,
        category: 'food',
        type: TransactionTypes.expense,
      ),
      tx(
        id: '3',
        price: 180,
        category: 'food',
        type: TransactionTypes.expense,
      ),
      tx(
        id: '4',
        price: 90,
        category: 'transport',
        type: TransactionTypes.expense,
      ),
    ];

    final result = useCase(transactions);

    expect(result.totalIncome, 500);
    expect(result.totalExpenses, 390);
    expect(result.highestSingleExpense, 180);
    expect(result.highestCategoryExpense, 300);
    expect(result.mostExpensiveCategory, 'food');
    expect(result.balance, 110);
    expect(
      result.categoryExpenses,
      equals(<String, double>{'food': 300, 'transport': 90}),
    );
    expect(result.averageExpense, 195);
  });
}
