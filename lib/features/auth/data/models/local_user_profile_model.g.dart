// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUserProfileModelAdapter extends TypeAdapter<LocalUserProfileModel> {
  @override
  final typeId = 1;

  @override
  LocalUserProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUserProfileModel(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      weeklySpending: fields[3] as String,
      forGoal: fields[4] as bool,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalUserProfileModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.weeklySpending)
      ..writeByte(4)
      ..write(obj.forGoal)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUserProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
