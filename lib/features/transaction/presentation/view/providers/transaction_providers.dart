import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finance_tracking/features/transaction/data/models/transaction_model.dart';
import 'package:finance_tracking/features/transaction/domain/use_cases/get_transaction_usecase.dart';
import 'package:finance_tracking/features/transaction/presentation/view/notifiers/get_transaction_notitifer.dart';
import 'package:finance_tracking/features/transaction/presentation/view/notifiers/transaction_type_notifier.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/get_transaction_states.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/transaction_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/transaction/domain/use_cases/add_transaction_usecase.dart';
import 'package:finance_tracking/features/transaction/presentation/view/notifiers/add_transaction_notifier.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/add_transaction_state.dart';
import 'package:finance_tracking/features/transaction/domain/use_cases/sync_transactions_usecase.dart';

final transactionTypeProvider =
    StateNotifierProvider<TransactionTypeNotifier, TransactionType>((ref) {
      return TransactionTypeNotifier();
    });

final addTransactionProvider =
    StateNotifierProvider<AddTransactionNotifier, AddTransactionState>((ref) {
      return AddTransactionNotifier(
        addTransactionUseCase: getIt<AddTransactionUseCase>(),
        ref: ref,
      );
    });

final selectedCategoryProvider = StateProvider.autoDispose<Category>((ref) {
  return Category.food;
});

final getTransactionProvider = StateNotifierProvider<GetTransactionNotitifer, GetTransactionState>((ref) {
  return GetTransactionNotitifer(getTransactionUseCase: getIt<GetTransactionUseCase>());
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final transactionCategoryFilterProvider = StateProvider<String>((ref) => 'all');

final filteredTransactionsProvider = Provider<List<dynamic>>((ref) {
  final state = ref.watch(getTransactionProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final category = ref.watch(transactionCategoryFilterProvider);

  bool fuzzyMatch(String target, String query) {
    if (query.isEmpty) return true;
    target = target.toLowerCase();
    query = query.toLowerCase();
    int targetIndex = 0;
    int queryIndex = 0;
    while (targetIndex < target.length && queryIndex < query.length) {
      if (target[targetIndex] == query[queryIndex]) {
        queryIndex++;
      }
      targetIndex++;
    }
    return queryIndex == query.length;
  }

  if (state is GetTransactionSuccess) {
    return state.transactions.where((tx) {
      final matchesQuery = fuzzyMatch(tx.name, query) || fuzzyMatch(tx.category, query);
      final matchesCategory = category == 'all' || tx.category.toLowerCase() == category.toLowerCase();
      return matchesQuery && matchesCategory;
    }).toList();
  }
  return [];
});

final syncProvider = Provider<void>((ref) {
  final syncUseCase = getIt<SyncTransactionsUseCase>();
  
  Future.microtask(() => syncUseCase());

  Connectivity().onConnectivityChanged.listen((results) {
    if (!results.contains(ConnectivityResult.none)) {
      syncUseCase();
    }
  });
});

