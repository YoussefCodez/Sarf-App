class RemoteGoalEntity {
  final String id;
  final DateTime createdAt;
  final String name;
  final String? image;
  final double price;
  final String userId;

  RemoteGoalEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    this.image,
    required this.price,
    required this.userId,
  });
}
