import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/on_boarding/domain/usecases/save_weekly_spending_usecase.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/money_tracking_intnet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeekMoneyTrackingNotifier extends Notifier<double> {
  @override
  double build() {
    return 50;
  }

  void handleIntent(MoneyTrackingIntent intent) {
    switch (intent) {
      case MoneyTrackingIntentUpdate():
        _updateWeekMoneyTracking(intent.weekMoneyTracking);
      case MoneyTrackingIntentFinish():
        _finish();
      case MoneyTrackingIntentSkip():
        _skip();
    }
  }

  void _updateWeekMoneyTracking(double weekMoneyTracking) {
    state = weekMoneyTracking;
  }

  void _finish() async {
    await getIt<SaveWeeklySpendingUseCase>().execute(state);
    // TODO: Navigate to Home or whatever is next
  }

  void _skip() async {
    await getIt<SaveWeeklySpendingUseCase>().execute(-1);
    // TODO: Navigate to Home or whatever is next
  }
}