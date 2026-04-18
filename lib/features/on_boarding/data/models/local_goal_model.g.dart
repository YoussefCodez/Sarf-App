// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalGoalModelAdapter extends TypeAdapter<LocalGoalModel> {
  @override
  final typeId = 0;

  @override
  LocalGoalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalGoalModel(
      imagePath: fields[0] as String,
      name: fields[1] as String,
      price: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalGoalModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalGoalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
