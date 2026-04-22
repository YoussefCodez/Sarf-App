class UserFinanceEntity {
  final String userId;
  final double goalAmount;
  final double weeklySpend;

  const UserFinanceEntity({
    required this.userId,
    required this.goalAmount,
    required this.weeklySpend,
  });
}
