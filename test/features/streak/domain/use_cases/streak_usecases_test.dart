import 'package:dartz/dartz.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';
import 'package:finance_tracking/features/streak/domain/repositories/streak_repository_contract.dart';
import 'package:finance_tracking/features/streak/domain/use_cases/get_streak_usecase.dart';
import 'package:finance_tracking/features/streak/domain/use_cases/record_check_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeStreakRepository implements StreakRepositoryContract {
  bool getStreakCalled = false;
  bool recordCheckInCalled = false;

  Either<String, StreakEntity> getStreakResponse = Right(
    StreakEntity(
      userId: 'user-1',
      currentStreak: 3,
      longestStreak: 7,
      lastCheckInDate: DateTime.utc(2026, 5, 7),
    ),
  );

  Either<String, StreakEntity> recordCheckInResponse = Right(
    StreakEntity(
      userId: 'user-1',
      currentStreak: 4,
      longestStreak: 7,
      lastCheckInDate: DateTime.utc(2026, 5, 8),
    ),
  );

  @override
  Future<Either<String, StreakEntity>> getStreak() async {
    getStreakCalled = true;
    return getStreakResponse;
  }

  @override
  Future<Either<String, StreakEntity>> recordCheckIn() async {
    recordCheckInCalled = true;
    return recordCheckInResponse;
  }
}

void main() {
  group('GetStreakUseCase', () {
    test('calls repository getStreak and returns success response', () async {
      final repository = FakeStreakRepository();
      final useCase = GetStreakUseCase(repository: repository);

      final result = await useCase();

      expect(repository.getStreakCalled, true);
      expect(result.isRight(), true);
    });

    test('returns same failure from repository', () async {
      final repository = FakeStreakRepository()
        ..getStreakResponse = const Left('failed to load streak');
      final useCase = GetStreakUseCase(repository: repository);

      final result = await useCase();

      expect(repository.getStreakCalled, true);
      expect(result, const Left('failed to load streak'));
    });
  });

  group('RecordCheckInUseCase', () {
    test('calls repository recordCheckIn and returns success response', () async {
      final repository = FakeStreakRepository();
      final useCase = RecordCheckInUseCase(repository: repository);

      final result = await useCase();

      expect(repository.recordCheckInCalled, true);
      expect(result.isRight(), true);
    });

    test('returns same failure from repository', () async {
      final repository = FakeStreakRepository()
        ..recordCheckInResponse = const Left('failed to check in');
      final useCase = RecordCheckInUseCase(repository: repository);

      final result = await useCase();

      expect(repository.recordCheckInCalled, true);
      expect(result, const Left('failed to check in'));
    });
  });
}
