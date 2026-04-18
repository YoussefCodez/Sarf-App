class UserProfileEntity {
  final String id;
  final String name;
  final String email;
  final String weeklySpending;
  final bool forGoal;
  final DateTime createdAt;
  
  UserProfileEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.weeklySpending,
    required this.forGoal,
    required this.createdAt,
  });
}