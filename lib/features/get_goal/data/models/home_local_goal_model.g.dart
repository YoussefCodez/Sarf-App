// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_local_goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeLocalGoalModelAdapter extends TypeAdapter<HomeLocalGoalModel> {
  @override
  final typeId = 6;

  @override
  HomeLocalGoalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeLocalGoalModel(
      id: fields[0] as String,
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      userId: fields[3] as String,
      price: (fields[4] as num).toDouble(),
      image: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeLocalGoalModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeLocalGoalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
