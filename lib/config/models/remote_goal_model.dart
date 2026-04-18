import 'package:finance_tracking/config/entities/remote_goal_entity.dart';

class RemoteGoalModel extends RemoteGoalEntity {
  RemoteGoalModel({
    required super.id,
    required super.createdAt,
    required super.name,
    super.image,
    required super.price,
    required super.userId,
  });

  factory RemoteGoalModel.fromSupabase(Map<String, dynamic> map) {
    return RemoteGoalModel(
      id: map['id'] ?? "",
      createdAt: DateTime.parse(
        map['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      name: map['name'] ?? "Unknown Goal",
      image: map['image'],
      price: (map['price'] ?? 0.0).toDouble(),
      userId: map['user_id'] ?? "",
    );
  }

  Map<String, dynamic> toSupabase() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  RemoteGoalModel copyWith({String? id, String? userId}) {
    return RemoteGoalModel(
      id: id ?? this.id,
      createdAt: createdAt,
      name: name,
      image: image,
      price: price,
      userId: userId ?? this.userId,
    );
  }
}
