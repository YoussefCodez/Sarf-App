import 'package:finance_tracking/features/transaction/data/models/transaction_model.dart';
import 'package:finance_tracking/features/transaction/domain/entities/local_transaction_entity.dart';
import 'package:finance_tracking/features/transaction/domain/entities/transaction_entity.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'local_transaction_model.g.dart';

@HiveType(typeId: 9)
enum SyncStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  synced,
  @HiveField(2)
  failed
}

@HiveType(typeId: 8)
class LocalTransactionModel extends LocalTransactionEntity {
  @HiveField(0)
  @override
  final String id;
  @HiveField(1)
  @override
  final String name;
  @HiveField(2)
  @override
  final double price;
  @HiveField(3)
  @override
  final String category;
  @HiveField(4)
  @override
  final DateTime createdAt;
  @HiveField(5)
  @override
  final String type;
  @HiveField(6)
  @override
  final String userId;
  @HiveField(7)
  @override
  final String? note;
  @HiveField(8)
  final SyncStatus syncStatus;

  LocalTransactionModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.createdAt,
    required this.type,
    required this.userId,
    this.note,
    this.syncStatus = SyncStatus.pending,
  }) : super(
         id: id,
         name: name,
         price: price,
         category: category,
         createdAt: createdAt,
         type: type,
         userId: userId,
         note: note,
       );

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    category,
    createdAt,
    type,
    userId,
    note,
    syncStatus,
  ];

  LocalTransactionModel copyWith({
    String? id,
    String? name,
    double? price,
    String? category,
    DateTime? createdAt,
    String? type,
    String? userId,
    String? note,
    SyncStatus? syncStatus,
  }) {
    return LocalTransactionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      note: note ?? this.note,
      syncStatus: syncStatus ?? this.syncStatus,
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

  TransactionModel toModel() {
    return TransactionModel(
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
