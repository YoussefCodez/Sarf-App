import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/entities/transaction_entity.dart';
import 'package:finance_tracking/core/app_strings/transaction_strings.dart';
import 'package:finance_tracking/features/transaction/domain/repositories/transaction_repository_contract.dart';
import 'package:finance_tracking/features/transaction/domain/use_cases/add_transaction_usecase.dart';
import 'package:finance_tracking/features/transaction/domain/use_cases/get_transaction_usecase.dart';
import 'package:finance_tracking/features/transaction/domain/use_cases/sync_transactions_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeTransactionRepository implements TransactionRepositoryContract {
  String? addName;
  double? addPrice;
  String? addCategory;
  DateTime? addCreatedAt;
  String? addType;
  String? addNote;
  int? getLimit;
  bool syncCalled = false;

  Either<String, void> addResponse = const Right(null);
  Either<String, List<TransactionEntity>> getResponse = const Right(
    <TransactionEntity>[],
  );
  Either<String, void> syncResponse = const Right(null);

  @override
  Future<Either<String, void>> addTransaction({
    required String name,
    required double price,
    required String category,
    required DateTime createdAt,
    required String type,
    String? note,
  }) async {
    addName = name;
    addPrice = price;
    addCategory = category;
    addCreatedAt = createdAt;
    addType = type;
    addNote = note;
    return addResponse;
  }

  @override
  Future<Either<String, List<TransactionEntity>>> getTransactions({
    int? limit,
  }) async {
    getLimit = limit;
    return getResponse;
  }

  @override
  Future<Either<String, void>> syncTransactions() async {
    syncCalled = true;
    return syncResponse;
  }
}

void main() {
  group('AddTransactionUseCase', () {
    late FakeTransactionRepository repository;
    late AddTransactionUseCase useCase;

    setUp(() {
      repository = FakeTransactionRepository();
      useCase = AddTransactionUseCase(repository: repository);
    });

    test('returns empty name error for non-income when name is blank', () async {
      final result = await useCase(
        name: '   ',
        priceString: '100',
        category: 'food',
        createdAt: DateTime.utc(2026, 5, 7),
        type: 'expense',
      );

      expect(result, const Left(TransactionStrings.emptyNameError));
      expect(repository.addName, isNull);
    });

    test('allows blank name for income and trims note before repository call', () async {
      final date = DateTime.utc(2026, 5, 7);

      final result = await useCase(
        name: '   ',
        priceString: '250.5',
        category: 'salary',
        createdAt: date,
        type: 'income',
        note: '  monthly salary  ',
      );

      expect(result, const Right(null));
      expect(repository.addName, '');
      expect(repository.addPrice, 250.5);
      expect(repository.addCategory, 'salary');
      expect(repository.addCreatedAt, date);
      expect(repository.addType, 'income');
      expect(repository.addNote, 'monthly salary');
    });

    test('returns invalid price error when price is not positive', () async {
      final result = await useCase(
        name: 'Coffee',
        priceString: '0',
        category: 'food',
        createdAt: DateTime.utc(2026, 5, 7),
        type: 'expense',
      );

      expect(result, const Left(TransactionStrings.invalidPriceError));
      expect(repository.addName, isNull);
    });
  });

  group('GetTransactionUseCase', () {
    test('forwards limit to repository', () async {
      final repository = FakeTransactionRepository();
      final useCase = GetTransactionUseCase(repository: repository);

      await useCase(limit: 20);

      expect(repository.getLimit, 20);
    });
  });

  group('SyncTransactionsUseCase', () {
    test('calls repository sync and returns its response', () async {
      final repository = FakeTransactionRepository();
      repository.syncResponse = const Left('sync failed');
      final useCase = SyncTransactionsUseCase(repository: repository);

      final result = await useCase();

      expect(repository.syncCalled, true);
      expect(result, const Left('sync failed'));
    });
  });
}
