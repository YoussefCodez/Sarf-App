import 'package:finance_tracking/features/daily_advice/domain/entities/user_finance_entity.dart';
import 'package:finance_tracking/features/daily_advice/domain/rules/advice_rule.dart';

class SpendingOptimizationRule implements AdviceRule {
  @override
  bool isApplicable(UserFinanceEntity financeData) {
    // Applicable if the user spends more than 3000 EGP per week
    return financeData.weeklySpend > 3000;
  }

  @override
  String generateAdvice(UserFinanceEntity financeData) {
    return "Did you know cooking at home can cut your weekly expenses by 30%? A small change today compounds into significant wealth tomorrow.";
  }
}
