import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/services/network_info_service.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/features/transaction/data/data_source/transaction_local_data_source.dart';
import 'package:finance_tracking/features/transaction/data/data_source/transaction_remote_data_source.dart';
import 'package:finance_tracking/features/transaction/data/models/local_transaction_model.dart';
import 'package:finance_tracking/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:finance_tracking/features/transaction/domain/entities/transaction_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

@GenerateMocks([
  TransactionRemoteDataSource,
  TransactionLocalDataSource,
  SupabaseErrorHandlerService,
  NetworkInfo,
  Uuid,
])
import 'transaction_repository_impl_test.mocks.dart';

void main() {
  late TransactionRepositoryImpl transactionRepositoryImpl;
  late MockTransactionRemoteDataSource mockRemoteTransactionDataSource;
  late MockTransactionLocalDataSource mockTransactionLocalDataSource;
  late MockSupabaseErrorHandlerService mockSupabaseErrorHandlerService;
  late MockNetworkInfo networkInfo;
  late MockUuid uuid;
  setUp(() {
    mockRemoteTransactionDataSource = MockTransactionRemoteDataSource();
    mockTransactionLocalDataSource = MockTransactionLocalDataSource();
    mockSupabaseErrorHandlerService = MockSupabaseErrorHandlerService();
    networkInfo = MockNetworkInfo();
    uuid = MockUuid();
    transactionRepositoryImpl = TransactionRepositoryImpl(
      remoteDataSource: mockRemoteTransactionDataSource,
      localDataSource: mockTransactionLocalDataSource,
      supabaseErrorHandlerService: mockSupabaseErrorHandlerService,
      networkInfo: networkInfo,
    );
  });

  group('addTransaction', () {
    test('should return Right(null) when remote call is successful', () async {
      // Arrange
      bool isOnline = true;
      when(networkInfo.isConnected).thenAnswer((_) async => isOnline);
      when(mockRemoteTransactionDataSource.getUserId()).thenReturn('1');
      when(uuid.v4()).thenReturn('unique-id');
      when(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).thenAnswer((_) async => {});
      when(
        mockTransactionLocalDataSource.saveTransactions(any),
      ).thenAnswer((_) async => {});

      // Act
      final result = await transactionRepositoryImpl.addTransaction(
        name: 'Test',
        price: 100,
        category: 'Test',
        createdAt: DateTime.now(),
        type: 'Test',
      );

      // Assert
      expect(result, const Right(null));
      verify(networkInfo.isConnected).called(1);
      verify(mockRemoteTransactionDataSource.getUserId()).called(1);
      verify(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).called(1);
      verify(mockTransactionLocalDataSource.saveTransactions(any)).called(1);
    });

    test('should return Left(error) when remote call fails', () async {
      // Arrange
      bool isOnline = true;
      when(networkInfo.isConnected).thenAnswer((_) async => isOnline);
      when(mockRemoteTransactionDataSource.getUserId()).thenReturn('1');
      when(uuid.v4()).thenReturn('unique-id');
      when(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).thenThrow(Exception('Failed to insert transaction'));
      when(
        mockSupabaseErrorHandlerService.handle(any),
      ).thenReturn('Failed to insert transaction');
      when(
        mockTransactionLocalDataSource.saveTransactions(any),
      ).thenAnswer((_) async => {});

      // Act
      final result = await transactionRepositoryImpl.addTransaction(
        name: 'Test',
        price: 100,
        category: 'Test',
        createdAt: DateTime.now(),
        type: 'Test',
      );

      // Assert
      expect(result, Left('Failed to insert transaction'));
      verify(networkInfo.isConnected).called(1);
      verify(mockRemoteTransactionDataSource.getUserId()).called(1);
      verify(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).called(1);
      verify(mockTransactionLocalDataSource.saveTransactions(any)).called(1);
    });

    test('should return Right(null) when local call is successful', () async {
      // Arrange
      bool isOnline = false;
      when(networkInfo.isConnected).thenAnswer((_) async => isOnline);
      when(mockRemoteTransactionDataSource.getUserId()).thenReturn('1');
      when(uuid.v4()).thenReturn('unique-id');
      when(
        mockTransactionLocalDataSource.saveTransactions(any),
      ).thenAnswer((_) async => {});

      // Act
      final result = await transactionRepositoryImpl.addTransaction(
        name: 'Test',
        price: 100,
        category: 'Test',
        createdAt: DateTime.now(),
        type: 'Test',
      );

      // Assert
      expect(result, const Right(null));
      verify(networkInfo.isConnected).called(1);
      verify(mockRemoteTransactionDataSource.getUserId()).called(1);
      verify(mockTransactionLocalDataSource.saveTransactions(any)).called(1);
    });
  });

  group('getTransactions', () {
    test(
      'should return Right(List<TransactionEntity>) when remote call is successful',
      () async {
        // Arrange
        bool isOnline = true;
        when(networkInfo.isConnected).thenAnswer((_) async => isOnline);
        when(
          mockRemoteTransactionDataSource.getTransactions(
            limit: anyNamed('limit'),
          ),
        ).thenAnswer((_) async => []);
        when(
          mockTransactionLocalDataSource.saveTransactions(any),
        ).thenAnswer((_) async => {});

        // Act
        final result = await transactionRepositoryImpl.getTransactions();

        // Assert
        expect(result.isRight(), true);

        result.fold((l) => fail('Expected Right but got Left'), (r) {
          expect(r, isA<List<TransactionEntity>>());
          expect(r, isEmpty);
        });
        verify(networkInfo.isConnected).called(1);
        verify(
          mockRemoteTransactionDataSource.getTransactions(
            limit: anyNamed('limit'),
          ),
        ).called(1);
        verify(mockTransactionLocalDataSource.saveTransactions(any)).called(1);
      },
    );

    test(
      'should return Right(List<TransactionEntity>) when local call is successful',
      () async {
        // Arrange
        bool isOnline = false;
        when(networkInfo.isConnected).thenAnswer((_) async => isOnline);
        when(
          mockTransactionLocalDataSource.getTransactions(
            limit: anyNamed('limit'),
          ),
        ).thenAnswer((_) async => []);

        // Act
        final result = await transactionRepositoryImpl.getTransactions();

        // Assert
        expect(result.isRight(), true);

        result.fold((l) => fail('Expected Right but got Left'), (r) {
          expect(r, isA<List<TransactionEntity>>());
          expect(r, isEmpty);
        });
        verify(networkInfo.isConnected).called(1);
        verify(
          mockTransactionLocalDataSource.getTransactions(
            limit: anyNamed('limit'),
          ),
        ).called(1);
      },
    );

    test('should return Left(error) when remote call fails', () async {
      // Arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      when(
        mockRemoteTransactionDataSource.getTransactions(
          limit: anyNamed('limit'),
        ),
      ).thenThrow(Exception('Failed to get transactions'));

      when(
        mockTransactionLocalDataSource.getTransactions(
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => []);

      when(
        mockSupabaseErrorHandlerService.handle(any),
      ).thenReturn('Failed to get transactions');

      // Act
      final result = await transactionRepositoryImpl.getTransactions();

      // Assert
      expect(result.isLeft(), true);

      result.fold((l) {
        expect(l, 'Failed to get transactions');
      }, (r) => fail('Expected Left but got Right'));
      verify(networkInfo.isConnected).called(1);
      verify(
        mockRemoteTransactionDataSource.getTransactions(
          limit: anyNamed('limit'),
        ),
      ).called(1);
      verify(
        mockTransactionLocalDataSource.getTransactions(
          limit: anyNamed('limit'),
        ),
      ).called(1);
    });
  });

  group('syncTransactions', () {
    test('should sync pending transactions successfully', () async {
      // Arrange
      final tx = LocalTransactionModel(
        id: '1',
        userId: 'u',
        name: 'test',
        price: 10,
        category: 'cat',
        createdAt: DateTime.now(),
        type: 'expense',
        note: null,
        syncStatus: SyncStatus.pending,
      );

      when(
        mockTransactionLocalDataSource.getTransactions(),
      ).thenAnswer((_) async => [tx]);

      when(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).thenAnswer((_) async => Future.value());

      when(
        mockTransactionLocalDataSource.saveTransactions(any),
      ).thenAnswer((_) async => Future.value());

      // Act
      final result = await transactionRepositoryImpl.syncTransactions();

      // Assert
      expect(result.isRight(), true);

      verify(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).called(1);

      verify(mockTransactionLocalDataSource.saveTransactions(any)).called(1);
    });

    test('should return Right(null) when no pending transactions', () async {
      // Arrange
      when(mockTransactionLocalDataSource.getTransactions()).thenAnswer(
        (_) async => [
          LocalTransactionModel(
            id: '1',
            userId: 'u',
            name: 'test',
            price: 10,
            category: 'cat',
            createdAt: DateTime.now(),
            type: 'expense',
            note: null,
            syncStatus: SyncStatus.synced,
          ),
        ],
      );

      // Act
      final result = await transactionRepositoryImpl.syncTransactions();

      // Assert
      expect(result.isRight(), true);

      verifyNever(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      );
      verifyNever(mockTransactionLocalDataSource.saveTransactions(any));
    });

    test('should mark transaction as failed when remote throws', () async {
      // Arrange
      final tx = LocalTransactionModel(
        id: '1',
        userId: 'u',
        name: 'test',
        price: 10,
        category: 'cat',
        createdAt: DateTime.now(),
        type: 'expense',
        note: null,
        syncStatus: SyncStatus.pending,
      );

      when(
        mockTransactionLocalDataSource.getTransactions(),
      ).thenAnswer((_) async => [tx]);

      when(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).thenThrow(Exception('network error'));

      when(
        mockTransactionLocalDataSource.saveTransactions(any),
      ).thenAnswer((_) async => Future.value());

      when(
        mockSupabaseErrorHandlerService.handle(any),
      ).thenReturn('sync failed');

      // Act
      final result = await transactionRepositoryImpl.syncTransactions();

      // Assert
      expect(result.isLeft(), true);

      result.fold(
        (l) => expect(l, 'sync failed'),
        (r) => fail('Expected Left'),
      );

      verify(mockTransactionLocalDataSource.saveTransactions(any)).called(1);
    });

    test('should sync multiple pending transactions in parallel', () async {
      // Arrange
      final tx1 = LocalTransactionModel(
        id: '1',
        userId: 'u',
        name: 't1',
        price: 10,
        category: 'cat',
        createdAt: DateTime.now(),
        type: 'expense',
        note: null,
        syncStatus: SyncStatus.pending,
      );

      final tx2 = tx1.copyWith(id: '2');

      when(
        mockTransactionLocalDataSource.getTransactions(),
      ).thenAnswer((_) async => [tx1, tx2]);

      when(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).thenAnswer((_) async => Future.value());

      when(
        mockTransactionLocalDataSource.saveTransactions(any),
      ).thenAnswer((_) async => Future.value());

      // Act
      final result = await transactionRepositoryImpl.syncTransactions();

      // Assert
      expect(result.isRight(), true);

      verify(
        mockRemoteTransactionDataSource.insertTransaction(
          data: anyNamed('data'),
        ),
      ).called(2);
    });
  });
}
