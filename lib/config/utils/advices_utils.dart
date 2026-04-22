import 'package:intl/intl.dart';

abstract class AdvicesUtils {
  static String getShouldSave({
    required double goal,
    required double oldSpend,
  }) {
    double savingRate;

    if (oldSpend <= 2000) {
      savingRate = 0.15;
    } else if (oldSpend < 5000) {
      savingRate = 0.25;
    } else {
      savingRate = 0.5;
    }

    final savingPerWeek = oldSpend * savingRate;
    final newSpend = oldSpend - savingPerWeek;

    final weeks = getWeeksToReachGoal(goal, savingPerWeek);

    return "If you spend ${NumberFormat('#,###').format(newSpend.toInt())} EGP per week, you will save ${NumberFormat('#,###').format(savingPerWeek.toInt())} and reach your goal in $weeks weeks";
  }

  static String getWeeksToReachGoal(double goal, double shouldSave) {
    final double weeks = goal / shouldSave;
    return weeks.toInt().toString();
  }

  static double getPercentage(double goal, double spend) {
    final double percentage = spend / goal;
    return percentage;
  }
}
