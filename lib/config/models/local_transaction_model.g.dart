// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalTransactionModelAdapter extends TypeAdapter<LocalTransactionModel> {
  @override
  final typeId = 8;

  @override
  LocalTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalTransactionModel(
      id: fields[0] as String,
      name: fields[1] as String,
      price: (fields[2] as num).toDouble(),
      category: fields[3] as String,
      createdAt: fields[4] as DateTime,
      type: fields[5] as String,
      userId: fields[6] as String,
      note: fields[7] as String?,
      syncStatus: fields[8] == null
          ? SyncStatus.pending
          : fields[8] as SyncStatus,
    );
  }

  @override
  void write(BinaryWriter writer, LocalTransactionModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.note)
      ..writeByte(8)
      ..write(obj.syncStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SyncStatusAdapter extends TypeAdapter<SyncStatus> {
  @override
  final typeId = 9;

  @override
  SyncStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SyncStatus.pending;
      case 1:
        return SyncStatus.synced;
      case 2:
        return SyncStatus.failed;
      default:
        return SyncStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, SyncStatus obj) {
    switch (obj) {
      case SyncStatus.pending:
        writer.writeByte(0);
      case SyncStatus.synced:
        writer.writeByte(1);
      case SyncStatus.failed:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyncStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
