import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String userId;
  final String name;
  final double price;
  final String category;
  final DateTime createdAt;
  final String type;
  final String? note;

  const TransactionEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.price,
    required this.category,
    required this.createdAt,
    required this.type,
    this.note,
  });

  @override
  List<Object?> get props => [id, name, price, category, createdAt, type, note];
}
