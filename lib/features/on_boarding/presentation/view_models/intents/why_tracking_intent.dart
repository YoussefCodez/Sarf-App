sealed class WhyTrackingIntent {
  const WhyTrackingIntent();
}

class SetIsSavingForGoalIntent extends WhyTrackingIntent {
  final bool isSavingForGoal;

  const SetIsSavingForGoalIntent({required this.isSavingForGoal});
}

class SubmitSavingPreferenceIntent extends WhyTrackingIntent {
  const SubmitSavingPreferenceIntent();
}
