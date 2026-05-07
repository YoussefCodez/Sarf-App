import 'package:finance_tracking/config/models/local_transaction_model.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String name;
  final double price;
  final String category;
  final DateTime createdAt;
  final String type;
  final String? note;

  const TransactionModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.createdAt,
    required this.type,
    required this.userId,
    this.note,
  });

  factory TransactionModel.fromSupabase(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      category: json['category']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      type: json['type']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      note: json['note']?.toString(),
    );
  }

  Map<String, dynamic> toSupabase() {
    return {
      if (id.isNotEmpty) 'id': id,
      'name': name,
      'price': price,
      'category': category,
      'created_at': createdAt.toIso8601String(),
      'type': type,
      'user_id': userId,
      if (note != null && note!.isNotEmpty) 'note': note,
    };
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      price: entity.price,
      category: entity.category,
      createdAt: entity.createdAt,
      type: entity.type,
      note: entity.note,
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      userId: userId,
      name: name,
      price: price,
      category: category,
      createdAt: createdAt,
      type: type,
      note: note,
    );
  }

  LocalTransactionModel toLocalModel() {
    return LocalTransactionModel(
      id: id,
      userId: userId,
      name: name,
      price: price,
      category: category,
      createdAt: createdAt,
      type: type,
      note: note,
    );
  }
}
