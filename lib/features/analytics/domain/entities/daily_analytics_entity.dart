class DailyAnalyticsEntity {
  final double totalIncome;
  final double totalExpenses;
  final double highestSingleExpense;
  final double highestCategoryExpense;
  final double balance;
  final String mostExpensiveCategory;
  final Map<String, double> categoryExpenses;

  DailyAnalyticsEntity({
    required this.totalIncome,
    required this.totalExpenses,
    required this.highestSingleExpense,
    required this.highestCategoryExpense,
    required this.balance,
    required this.mostExpensiveCategory,
    required this.categoryExpenses,
  });

  double get averageExpense {
    if (categoryExpenses.isEmpty) return 0.0;
    return totalExpenses / categoryExpenses.length;
  }
}