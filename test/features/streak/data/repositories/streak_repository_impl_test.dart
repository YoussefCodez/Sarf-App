import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/services/network_info_service.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/features/streak/data/data_source/streak_local_data_source.dart';
import 'package:finance_tracking/features/streak/data/data_source/streak_remote_data_source.dart';
import 'package:finance_tracking/features/streak/data/repositories/streak_repository_impl.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([
  StreakRemoteDataSource,
  StreakLocalDataSource,
  SupabaseErrorHandlerService,
  NetworkInfo,
])
import 'streak_repository_impl_test.mocks.dart';

void main() {
  late StreakRepositoryImpl repository;
  late MockStreakRemoteDataSource mockRemoteDataSource;
  late MockStreakLocalDataSource mockLocalDataSource;
  late MockSupabaseErrorHandlerService mockErrorHandler;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockStreakRemoteDataSource();
    mockLocalDataSource = MockStreakLocalDataSource();
    mockErrorHandler = MockSupabaseErrorHandlerService();
    mockNetworkInfo = MockNetworkInfo();

    repository = StreakRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      supabaseErrorHandlerService: mockErrorHandler,
      networkInfo: mockNetworkInfo,
    );
  });

  final tUserId = 'user-123';
  final tNow = DateTime.utc(2024, 1, 10, 10, 0, 0);
  final tTodayUtc = DateTime.utc(2024, 1, 10);
  final tYesterdayUtc = DateTime.utc(2024, 1, 9);
  final tOldDateUtc = DateTime.utc(2024, 1, 1);

  group('getStreak', () {
    test('should return remote data and cache it when online', () async {
      // Arrange
      final tStreak = StreakEntity(
        userId: tUserId,
        currentStreak: 5,
        longestStreak: 10,
        lastCheckInDate: tYesterdayUtc,
      );

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getStreak()).thenAnswer((_) async => tStreak);
      when(mockLocalDataSource.saveStreak(
        currentStreak: anyNamed('currentStreak'),
        longestStreak: anyNamed('longestStreak'),
        lastCheckInDate: anyNamed('lastCheckInDate'),
      )).thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.getStreak();

      // Assert
      expect(result, Right(tStreak));
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getStreak());
      verify(mockLocalDataSource.saveStreak(
        currentStreak: 5,
        longestStreak: 10,
        lastCheckInDate: tYesterdayUtc,
      ));
    });

    test('should return local data when offline', () async {
      // Arrange
      final tStreak = StreakEntity(
        userId: tUserId,
        currentStreak: 3,
        longestStreak: 5,
        lastCheckInDate: tYesterdayUtc,
      );

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getStreak()).thenAnswer((_) async => tStreak);

      // Act
      final result = await repository.getStreak();

      // Assert
      expect(result, Right(tStreak));
      verify(mockNetworkInfo.isConnected);
      verify(mockLocalDataSource.getStreak());
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should return empty streak when offline and no cache', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getStreak()).thenAnswer((_) async => null);

      // Act
      final result = await repository.getStreak();

      // Assert
      expect(result.isRight(), true);
      final streak = result.getOrElse(() => throw Exception());
      expect(streak.currentStreak, 0);
      expect(streak.userId, '');
    });

    test('should return cached streak when online remote fails', () async {
      final cached = StreakEntity(
        userId: tUserId,
        currentStreak: 2,
        longestStreak: 6,
        lastCheckInDate: tYesterdayUtc,
      );
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getStreak()).thenThrow(Exception('remote failed'));
      when(mockLocalDataSource.getStreak()).thenAnswer((_) async => cached);

      final result = await repository.getStreak();

      expect(result, Right(cached));
      verify(mockLocalDataSource.getStreak()).called(1);
      verifyNever(mockErrorHandler.handleError(any));
    });

    test('should return handled error when online remote fails and no cache', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getStreak()).thenThrow(Exception('remote failed'));
      when(mockLocalDataSource.getStreak()).thenAnswer((_) async => null);
      when(mockErrorHandler.handleError(any)).thenReturn('handled error');

      final result = await repository.getStreak();

      expect(result, const Left('handled error'));
      verify(mockLocalDataSource.getStreak()).called(1);
      verify(mockErrorHandler.handleError(any)).called(1);
    });
  });

  group('recordCheckIn', () {
    group('online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getUserId()).thenReturn(tUserId);
        when(mockRemoteDataSource.getServerTimestamp()).thenAnswer((_) async => tNow);
      });

      test('should return existing streak if checked in today', () async {
        // Arrange
        final existing = StreakEntity(
          userId: tUserId,
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: tTodayUtc,
        );
        when(mockRemoteDataSource.getStreak()).thenAnswer((_) async => existing);

        // Act
        final result = await repository.recordCheckIn();

        // Assert
        expect(result, Right(existing));
        verify(mockLocalDataSource.saveStreak(
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: tTodayUtc,
        ));
        verifyNever(mockRemoteDataSource.updateStreak(
          currentStreak: anyNamed('currentStreak'),
          longestStreak: anyNamed('longestStreak'),
          lastCheckInDate: anyNamed('lastCheckInDate'),
        ));
      });

      test('should increment streak if last check-in was yesterday', () async {
        // Arrange
        final existing = StreakEntity(
          userId: tUserId,
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: tYesterdayUtc,
        );
        when(mockRemoteDataSource.getStreak()).thenAnswer((_) async => existing);

        // Act
        final result = await repository.recordCheckIn();

        // Assert
        final expected = StreakEntity(
          userId: tUserId,
          currentStreak: 6,
          longestStreak: 10,
          lastCheckInDate: tTodayUtc,
        );
        expect(result, Right(expected));
        verify(mockRemoteDataSource.updateStreak(
          currentStreak: 6,
          longestStreak: 10,
          lastCheckInDate: tTodayUtc,
        ));
      });

      test('should reset streak to 1 if last check-in was long ago', () async {
        // Arrange
        final existing = StreakEntity(
          userId: tUserId,
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: tOldDateUtc,
        );
        when(mockRemoteDataSource.getStreak()).thenAnswer((_) async => existing);

        // Act
        final result = await repository.recordCheckIn();

        // Assert
        final expected = StreakEntity(
          userId: tUserId,
          currentStreak: 1,
          longestStreak: 10,
          lastCheckInDate: tTodayUtc,
        );
        expect(result, Right(expected));
      });
    });

    group('offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockRemoteDataSource.getUserId()).thenReturn(tUserId);
      });

      test('should handle offline consecutive increment', () async {
        // Arrange
        // (Note: Repository uses DateTime.now().toUtc() for offline today)
        // We can't easily mock DateTime.now() in the repository without a wrapper, 
        // but we can adjust our expect logic if it matches the current implementation.
        final existing = StreakEntity(
          userId: tUserId,
          currentStreak: 3,
          longestStreak: 5,
          lastCheckInDate: DateTime.now().toUtc().subtract(const Duration(days: 1)),
        );
        when(mockLocalDataSource.getStreak()).thenAnswer((_) async => existing);

        // Act
        final result = await repository.recordCheckIn();

        // Assert
        expect(result.isRight(), true);
        final streak = result.getOrElse(() => throw Exception());
        expect(streak.currentStreak, 4);
      });
    });

    test('should return handled error when recordCheckIn throws', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getUserId()).thenReturn(tUserId);
      when(mockRemoteDataSource.getServerTimestamp()).thenAnswer((_) async => tNow);
      when(mockRemoteDataSource.getStreak()).thenThrow(Exception('record failed'));
      when(mockErrorHandler.handleError(any)).thenReturn('record error');

      final result = await repository.recordCheckIn();

      expect(result, const Left('record error'));
      verify(mockErrorHandler.handleError(any)).called(1);
    });
  });
}
