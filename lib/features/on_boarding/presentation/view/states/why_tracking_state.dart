enum WhyTrackingStep { initial, addGoal }

class WhyTrackingState {
  final bool isSavingForGoal;
  final WhyTrackingStep step;

  WhyTrackingState({
    required this.isSavingForGoal,
    this.step = WhyTrackingStep.initial,
  });

  WhyTrackingState copyWith({
    bool? isSavingForGoal,
    WhyTrackingStep? step,
  }) {
    return WhyTrackingState(
      isSavingForGoal: isSavingForGoal ?? this.isSavingForGoal,
      step: step ?? this.step,
    );
  }
}
