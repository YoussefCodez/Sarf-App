import 'package:finance_tracking/features/daily_advice/domain/entities/user_finance_entity.dart';
import 'package:finance_tracking/features/daily_advice/domain/rules/advice_rule.dart';

class GoalBasedPredictionRule implements AdviceRule {
  @override
  bool isApplicable(UserFinanceEntity financeData, bool haveGoal) {
    return financeData.goalAmount > 0 && financeData.weeklySpend > 0 && haveGoal;
  }

  @override
  String generateAdvice(UserFinanceEntity financeData) {
    double savingRate;
    if (financeData.weeklySpend <= 2000) {
      savingRate = 0.15;
    } else if (financeData.weeklySpend < 5000) {
      savingRate = 0.25;
    } else {
      savingRate = 0.5;
    }

    double savingPerWeek = financeData.weeklySpend * savingRate;
    int weeksToGoal = (financeData.goalAmount / savingPerWeek).ceil();
    switch (weeksToGoal) {
      case >= 14:
        double monthsToGoal = weeksToGoal / 4.345;
        return "Keep it up! At an optimal savings rate, you could reach your goal of ${financeData.goalAmount.toInt()} EGP in just ${monthsToGoal.toInt()} months.";
      default:
        return "Keep it up! At an optimal savings rate, you could reach your goal of ${financeData.goalAmount.toInt()} EGP in just $weeksToGoal weeks.";
    }
  }
}
