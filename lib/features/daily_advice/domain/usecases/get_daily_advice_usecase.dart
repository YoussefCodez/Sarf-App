import 'package:finance_tracking/features/daily_advice/domain/entities/user_finance_entity.dart';
import 'package:finance_tracking/features/daily_advice/domain/rules/advice_rule.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDailyAdviceUseCase {
  final List<AdviceRule> rules;

  /// Dependency Injection expects a list of rules to be provided.
  GetDailyAdviceUseCase(@factoryParam this.rules);

  /// Executes the core logic. Time complexity is O(1) mostly for access after filtering.
  String execute(UserFinanceEntity financeData) {
    // 1. Filter out rules that are not applicable for the user's current context
    final applicableRules = rules.where((rule) => rule.isApplicable(financeData)).toList();

    if (applicableRules.isEmpty) {
      return "Keep tracking your expenses to unlock personalized daily advice!";
    }

    // 2. Deterministic daily selection based on User ID and current Date.
    // This generates a stable index, ensuring the output is perfectly consistent per day.
    final now = DateTime.now();
    final dayKey = "${now.year}-${now.month}-${now.day}";
    final stableHash = (financeData.userId.hashCode ^ dayKey.hashCode).abs();
    
    // 3. Select the rule stably and return its output
    final selectedIndex = stableHash % applicableRules.length;
    final selectedRule = applicableRules[selectedIndex];

    return selectedRule.generateAdvice(financeData);
  }
}
