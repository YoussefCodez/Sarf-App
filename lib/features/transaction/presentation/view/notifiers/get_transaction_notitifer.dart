import 'package:finance_tracking/features/transaction/domain/use_cases/get_transaction_usecase.dart';
import 'package:finance_tracking/features/transaction/presentation/view/intents/transaction_intents.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/get_transaction_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class GetTransactionNotitifer extends StateNotifier<GetTransactionState> {
  final GetTransactionUseCase getTransactionUseCase;

  GetTransactionNotitifer({required this.getTransactionUseCase})
    : super(GetTransactionInitial());

  Future<void> handleIntent(TransactionIntent intent) async {
    if (intent is GetTransactionsIntent) {
      state = GetTransactionLoading();

      final result = await getTransactionUseCase(limit: intent.limit);

      result.fold(
        (failure) => state = GetTransactionError(failure),
        (transactions) => state = GetTransactionSuccess(transactions),
      );
    } else if (intent is AddTransactionLocallyIntent) {
      if (state is GetTransactionSuccess) {
        final currentTransactions =
            (state as GetTransactionSuccess).transactions;
        state = GetTransactionSuccess([
          intent.transaction,
          ...currentTransactions,
        ]);
      }
    }
  }
}
