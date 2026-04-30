import 'package:dartz/dartz.dart';
import 'package:finance_tracking/core/app_strings/transaction_strings.dart';
import 'package:finance_tracking/features/transaction/domain/repositories/transaction_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AddTransactionUseCase {
  final TransactionRepositoryContract repository;

  AddTransactionUseCase({required this.repository});

  Future<Either<String, void>> call({
    required String name,
    required String priceString,
    required String category,
    required DateTime createdAt,
    required String type,
    String? note,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty && type.toLowerCase() != 'income') {
      return const Left(TransactionStrings.emptyNameError);
    }

    final price = double.tryParse(priceString) ?? 0.0;
    if (price <= 0) {
      return const Left(TransactionStrings.invalidPriceError);
    }

    return repository.addTransaction(
      name: trimmedName,
      price: price,
      category: category,
      createdAt: createdAt,
      type: type,
      note: note?.trim(),
    );
  }
}
