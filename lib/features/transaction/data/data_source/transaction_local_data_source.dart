import 'package:finance_tracking/features/transaction/data/models/local_transaction_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:injectable/injectable.dart';

abstract interface class TransactionLocalDataSource {
  Future<void> saveTransactions(List<LocalTransactionModel> transactions);
  Future<List<LocalTransactionModel>> getTransactions({int? limit});
  Future<void> clearTransactions();
}

@LazySingleton(as: TransactionLocalDataSource)
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final HiveInterface _hive;
  static const String _boxName = 'transaction_box';

  TransactionLocalDataSourceImpl(this._hive);

  @override
  Future<void> saveTransactions(List<LocalTransactionModel> transactions) async {
    final box = await _hive.openBox(_boxName);
    final data = {for (var tx in transactions) tx.id: tx};
    await box.putAll(data);
  }

  Future<void> saveTransaction(LocalTransactionModel transaction) async {
    final box = await _hive.openBox(_boxName);
    await box.put(transaction.id, transaction);
  }

  @override
  Future<List<LocalTransactionModel>> getTransactions({int? limit}) async {
    final box = await _hive.openBox(_boxName);
    final transactions = box.values.cast<LocalTransactionModel>().toList();
    transactions.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return transactions.take(limit ?? transactions.length).toList();
  }

  @override
  Future<void> clearTransactions() async {
    final box = await _hive.openBox(_boxName);
    await box.clear();
  }
}