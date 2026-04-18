import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import '../../domain/entities/goal_entity.dart';

part 'local_goal_model.g.dart';

@HiveType(typeId: 0)
class LocalGoalModel extends HiveObject {
  @HiveField(0)
  final String imagePath;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String price;

  LocalGoalModel({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  factory LocalGoalModel.fromEntity(GoalEntity entity) {
    return LocalGoalModel(
      imagePath: entity.imagePath,
      name: entity.title,
      price: entity.description,
    );
  }

  GoalEntity toEntity() {
    return GoalEntity(imagePath: imagePath, title: name, description: price);
  }
}
