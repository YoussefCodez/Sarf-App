import 'package:finance_tracking/features/daily_advice/domain/entities/user_finance_entity.dart';
import 'package:finance_tracking/features/daily_advice/domain/rules/advice_rule.dart';
import 'package:intl/intl.dart';

class SavePercentageRule implements AdviceRule {
  @override
  bool isApplicable(UserFinanceEntity financeData, bool haveGoal) {
    return financeData.weeklySpend > 0;
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

    final savingPerWeek = financeData.weeklySpend * savingRate;
    final newSpend = financeData.weeklySpend - savingPerWeek;

    return "If you limit your spend to ${NumberFormat('#,###').format(newSpend.toInt())} EGP weekly, you can comfortably save ${NumberFormat('#,###').format(savingPerWeek.toInt())} EGP!";
  }
}
