import 'package:finance_tracking/features/transaction/presentation/view/states/transaction_states.dart';

sealed class TransactionIntent {}

class ChangeTransactionTypeIntent extends TransactionIntent {
  final TransactionType type;
  ChangeTransactionTypeIntent(this.type);
}

class ToggleTransactionTypeIntent extends TransactionIntent {}

class AddTransactionActionIntent extends TransactionIntent {
  final String name;
  final String priceString;
  final String category;
  final DateTime createdAt;
  final String type;
  final String? note;

  AddTransactionActionIntent({
    required this.name,
    required this.priceString,
    required this.category,
    required this.createdAt,
    required this.type,
    this.note,
  });
}

class GetTransactionsIntent extends TransactionIntent {
  final int? limit;
  GetTransactionsIntent({this.limit});
}

class AddTransactionLocallyIntent extends TransactionIntent {
  final dynamic transaction;
  AddTransactionLocallyIntent(this.transaction);
}
