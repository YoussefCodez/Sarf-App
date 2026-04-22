import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/on_boarding/domain/entities/goal_entity.dart';
import 'package:finance_tracking/features/on_boarding/domain/usecases/add_goal_usecase.dart';
import 'package:finance_tracking/features/on_boarding/domain/usecases/save_tracking_reason_usecase.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/intents/page_view_intent.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/intents/why_tracking_intent.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/providers/page_view_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/states/why_tracking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhyTrackingNotifier extends Notifier<WhyTrackingState> {
  @override
  WhyTrackingState build() {
    return WhyTrackingState(isSavingForGoal: false);
  }

  void handleIntent(WhyTrackingIntent intent) {
    if (intent is SetIsSavingForGoalIntent) {
      state = state.copyWith(
        isSavingForGoal: intent.isSavingForGoal,
        step: WhyTrackingStep.initial,
      );
    } else if (intent is SubmitSavingPreferenceIntent) {
      _handleSubmit();
    } else if (intent is AddGoalIntent) {
      _handleAddGoal(intent);
    }
  }

  void _handleSubmit() async {
    if (state.isSavingForGoal) {
      state = state.copyWith(step: WhyTrackingStep.addGoal);
    } else {
      await getIt<SaveTrackingReasonUseCase>().execute(false);
      ref.read(pageViewProvider.notifier).handleIntent(NextPageIntent());
    }
  }

  void _handleAddGoal(AddGoalIntent intent) async {
    final goal = GoalEntity(
      imagePath: intent.imagePath ?? '',
      title: intent.name,
      description: intent.amount,
    );
    await getIt<AddGoalUseCase>().execute(goal);
    await getIt<SaveTrackingReasonUseCase>().execute(true);
    ref.read(pageViewProvider.notifier).handleIntent(NextPageIntent());
  }
}
