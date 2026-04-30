import 'package:finance_tracking/features/transaction/domain/entities/transaction_entity.dart';

sealed class AddTransactionState {}

class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoading extends AddTransactionState {}

class AddTransactionSuccess extends AddTransactionState {
  final TransactionEntity transaction;
  AddTransactionSuccess(this.transaction);
}

class AddTransactionError extends AddTransactionState {
  final String errorMessage;
  AddTransactionError(this.errorMessage);
}
