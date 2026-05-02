sealed class GoalTrackerState {
  const GoalTrackerState();
}

class GoalTrackerInitial extends GoalTrackerState {
  const GoalTrackerInitial();
}

class GoalTrackerLoading extends GoalTrackerState {
  const GoalTrackerLoading();
}

class GoalTrackerSuccess extends GoalTrackerState {
  final double percentage;
  final double growthPercent;
  final String goalName;
  final double goalPrice;
  final double currentMoney;

  const GoalTrackerSuccess({
    required this.percentage,
    required this.growthPercent,
    required this.goalName,
    required this.goalPrice,
    required this.currentMoney,
  });

  factory GoalTrackerSuccess.skeleton() {
    return const GoalTrackerSuccess(
      percentage: 45.0,
      growthPercent: 12.0,
      goalName: "Saving for Car",
      goalPrice: 10000.0,
      currentMoney: 4500.0,
    );
  }
}

class GoalTrackerError extends GoalTrackerState {
  final String message;
  const GoalTrackerError(this.message);
}
