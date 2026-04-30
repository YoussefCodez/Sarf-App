import 'package:finance_tracking/features/transaction/domain/entities/transaction_entity.dart';
import 'package:finance_tracking/features/transaction/domain/use_cases/add_transaction_usecase.dart';
import 'package:finance_tracking/features/transaction/presentation/view/intents/transaction_intents.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/add_transaction_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AddTransactionNotifier extends StateNotifier<AddTransactionState> {
  final AddTransactionUseCase addTransactionUseCase;
  final Ref ref;

  AddTransactionNotifier({required this.addTransactionUseCase, required this.ref}) : super(AddTransactionInitial());

  Future<void> handleIntent(TransactionIntent intent) async {
    if (intent is AddTransactionActionIntent) {
      state = AddTransactionLoading();

      final result = await addTransactionUseCase(
        name: intent.name,
        priceString: intent.priceString,
        category: intent.category,
        createdAt: intent.createdAt,
        type: intent.type,
        note: intent.note,
      );

      result.fold(
        (failure) => state = AddTransactionError(failure),
        (_) {
          final newTransaction = TransactionEntity(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: intent.name,
            price: double.tryParse(intent.priceString) ?? 0,
            category: intent.category,
            createdAt: intent.createdAt,
            type: intent.type,
            userId: '',
            note: intent.note,
          );
          state = AddTransactionSuccess(newTransaction);
        },
      );
    }
  }
}
