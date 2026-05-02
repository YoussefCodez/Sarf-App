// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentCardModelAdapter extends TypeAdapter<PaymentCardModel> {
  @override
  final typeId = 21;

  @override
  PaymentCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentCardModel(
      id: fields[0] as String,
      cardNumber: fields[1] as String,
      cardHolder: fields[2] as String,
      expiryDate: fields[3] as String,
      baseColorValue: (fields[4] as num).toInt(),
      brand: fields[5] as CardBrand,
      balance: (fields[6] as num).toDouble(),
      userId: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentCardModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.cardHolder)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.baseColorValue)
      ..writeByte(5)
      ..write(obj.brand)
      ..writeByte(6)
      ..write(obj.balance)
      ..writeByte(7)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CardBrandAdapter extends TypeAdapter<CardBrand> {
  @override
  final typeId = 20;

  @override
  CardBrand read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CardBrand.visa;
      case 1:
        return CardBrand.mastercard;
      case 2:
        return CardBrand.meeza;
      default:
        return CardBrand.visa;
    }
  }

  @override
  void write(BinaryWriter writer, CardBrand obj) {
    switch (obj) {
      case CardBrand.visa:
        writer.writeByte(0);
      case CardBrand.mastercard:
        writer.writeByte(1);
      case CardBrand.meeza:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardBrandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
