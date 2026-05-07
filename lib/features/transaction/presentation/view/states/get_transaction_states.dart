import 'package:finance_tracking/config/entities/transaction_entity.dart';

sealed class GetTransactionState {}

class GetTransactionInitial extends GetTransactionState {}

class GetTransactionLoading extends GetTransactionState {}

class GetTransactionSuccess extends GetTransactionState {
  final List<TransactionEntity> transactions;

  GetTransactionSuccess(this.transactions);
}

class GetTransactionError extends GetTransactionState {
  final String error;

  GetTransactionError(this.error);
}