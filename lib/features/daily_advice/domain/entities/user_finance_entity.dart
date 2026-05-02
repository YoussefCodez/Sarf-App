class UserFinanceEntity {
  final String userId;
  final double goalAmount;
  final double weeklySpend;
  final bool haveGoal;

  const UserFinanceEntity({
    required this.userId,
    required this.goalAmount,
    required this.weeklySpend,
    required this.haveGoal,
  });
}
