import 'package:equatable/equatable.dart';
import 'package:finance_tracking/config/entities/remote_goal_entity.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'home_local_goal_model.g.dart';

@HiveType(typeId: 6)
class HomeLocalGoalModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final String userId;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final String? image;

  HomeLocalGoalModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.userId,
    required this.price,
    this.image,
  });

  factory HomeLocalGoalModel.fromEntity(RemoteGoalEntity entity) {
    return HomeLocalGoalModel(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
      userId: entity.userId,
      price: entity.price,
      image: entity.image,
    );
  }

  RemoteGoalEntity toEntity() {
    return RemoteGoalEntity(
      id: id,
      name: name,
      createdAt: createdAt,
      userId: userId,
      price: price,
      image: image,
    );
  }

  @override
  List<Object?> get props => [id, name, createdAt, userId, price, image];
}
