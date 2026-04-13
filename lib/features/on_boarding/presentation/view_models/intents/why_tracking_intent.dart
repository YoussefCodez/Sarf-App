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

class AddGoalIntent extends WhyTrackingIntent {
  final String name;
  final String amount;
  final String? imagePath;
  const AddGoalIntent({
    required this.name,
    required this.amount,
    this.imagePath,
  });
}
