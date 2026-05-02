import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'payment_card_model.g.dart';

@HiveType(typeId: 20)
enum CardBrand {
  @HiveField(0)
  visa,
  @HiveField(1)
  mastercard,
  @HiveField(2)
  meeza,
}

@HiveType(typeId: 21)
class PaymentCardModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String cardNumber;
  @HiveField(2)
  final String cardHolder;
  @HiveField(3)
  final String expiryDate;
  @HiveField(4)
  final int baseColorValue;
  @HiveField(5)
  final CardBrand brand;
  @HiveField(6)
  final double balance;
  @HiveField(7)
  final String userId;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.baseColorValue,
    required this.brand,
    required this.balance,
    required this.userId,
  });

  Color get baseColor => Color(baseColorValue);

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolder,
    String? expiryDate,
    int? baseColorValue,
    CardBrand? brand,
    double? balance,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolder: cardHolder ?? this.cardHolder,
      expiryDate: expiryDate ?? this.expiryDate,
      baseColorValue: baseColorValue ?? this.baseColorValue,
      brand: brand ?? this.brand,
      balance: balance ?? this.balance,
      userId: userId,
    );
  }
}
