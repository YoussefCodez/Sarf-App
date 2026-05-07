import 'package:finance_tracking/config/const/transaction_types.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';
import 'package:finance_tracking/features/analytics/domain/entities/daily_analytics_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CalculateDailyAnalyticsUseCase {
  DailyAnalyticsEntity call(List<TransactionEntity> transactions) {
    double income = 0;
    double expenses = 0;
    double highestSingleExpense = 0;
    final Map<String, double> expensesByCategory = {};

    for (final TransactionEntity tx in transactions) {
      if (tx.type == TransactionTypes.income) {
        income += tx.price;
      } else if (tx.type == TransactionTypes.expense) {
        expenses += tx.price;
        
        if (tx.price > highestSingleExpense) {
          highestSingleExpense = tx.price;
        }

        expensesByCategory.update(
          tx.category,
          (value) => value + tx.price,
          ifAbsent: () => tx.price,
        );
      }
    }

    String mostExpensiveCategory = "";
    double maxCategoryExpense = 0;
    expensesByCategory.forEach((category, total) {
      if (total > maxCategoryExpense) {
        maxCategoryExpense = total;
        mostExpensiveCategory = category;
      }
    });

    final balance = income - expenses;

    return DailyAnalyticsEntity(
      totalIncome: income,
      totalExpenses: expenses,
      highestSingleExpense: highestSingleExpense,
      highestCategoryExpense: maxCategoryExpense,
      balance: balance,
      mostExpensiveCategory: mostExpensiveCategory,
      categoryExpenses: expensesByCategory,
    );
  }
}
