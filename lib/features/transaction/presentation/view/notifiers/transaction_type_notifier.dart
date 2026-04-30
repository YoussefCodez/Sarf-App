import 'package:finance_tracking/features/transaction/presentation/view/intents/transaction_intents.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/transaction_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class TransactionTypeNotifier extends StateNotifier<TransactionType> {
  TransactionTypeNotifier() : super(TransactionType.expense);

  void handleIntent(TransactionIntent intent) {
    if (intent is ChangeTransactionTypeIntent) {
      state = intent.type;
    } else if (intent is ToggleTransactionTypeIntent) {
      state = state == TransactionType.income ? TransactionType.expense : TransactionType.income;
    }
  }

  void setIncome() => handleIntent(ChangeTransactionTypeIntent(TransactionType.income));
  void setExpense() => handleIntent(ChangeTransactionTypeIntent(TransactionType.expense));
  
  String get typeString => state == TransactionType.income ? 'income' : 'expense';
}
