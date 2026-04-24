class LocalGoalEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final String userId;
  final String price;
  final String image;
  LocalGoalEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.userId,
    required this.price,
    required this.image,
  });
}