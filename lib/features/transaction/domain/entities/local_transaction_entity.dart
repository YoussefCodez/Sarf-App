import 'package:equatable/equatable.dart';

class LocalTransactionEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String category;
  final DateTime createdAt;
  final String type;
  final String userId;
  final String? note;

  const LocalTransactionEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.createdAt,
    required this.type,
    required this.userId,
    this.note,
  });

  @override
  List<Object?> get props => [id, name, price, category, createdAt, type, userId, note];
}
