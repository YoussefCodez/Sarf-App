import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/page_view_intent.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/why_tracking_intent.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/providers/page_view_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/states/why_tracking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhyTrackingNotifier extends Notifier<WhyTrackingState> {
  @override
  WhyTrackingState build() {
    return WhyTrackingState(isSavingForGoal: false);
  }

  void handleIntent(WhyTrackingIntent intent) {
    switch (intent) {
      case SetIsSavingForGoalIntent(isSavingForGoal: final isSavingForGoal):
        setIsSavingForGoal(isSavingForGoal);
        break;
      case SubmitSavingPreferenceIntent():
        _handleSubmit();
        break;
    }
  }

  void setIsSavingForGoal(bool isSavingForGoal) {
    state = state.copyWith(isSavingForGoal: isSavingForGoal);
  }

  void _handleSubmit() {
    if (state.isSavingForGoal) {
      state = state.copyWith(step: WhyTrackingStep.addGoal);
    } else {
      ref.read(pageViewProvider.notifier).handleIntent(NextPageIntent());
    }
  }
}
