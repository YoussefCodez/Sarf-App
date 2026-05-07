import 'package:dartz/dartz.dart';
import 'package:finance_tracking/core/app_strings/notification_strings.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_repository.dart';
import 'package:finance_tracking/features/notifications/domain/usecases/check_streak_and_notify_use_case.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';
import 'package:finance_tracking/features/streak/domain/repositories/streak_repository_contract.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNotificationRepository implements NotificationRepository {
  int? shownId;
  String? shownTitle;
  String? shownBody;
  Either<String, void> showResponse = const Right(null);

  @override
  Future<Either<String, void>> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    shownId = id;
    shownTitle = title;
    shownBody = body;
    return showResponse;
  }

  @override
  Future<Either<String, void>> cancelNotification(int id) async {
    return const Right(null);
  }

  @override
  Future<Either<String, void>> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    return const Right(null);
  }
}

class FakeStreakRepository implements StreakRepositoryContract {
  Either<String, StreakEntity> getStreakResponse = Right(
    StreakEntity(
      userId: 'u1',
      currentStreak: 3,
      longestStreak: 7,
      lastCheckInDate: DateTime.now().subtract(const Duration(hours: 21)),
    ),
  );

  @override
  Future<Either<String, StreakEntity>> getStreak() async {
    return getStreakResponse;
  }

  @override
  Future<Either<String, StreakEntity>> recordCheckIn() async {
    throw UnimplementedError();
  }
}

void main() {
  test('returns repository error when getting streak fails', () async {
    final notificationRepository = FakeNotificationRepository();
    final streakRepository = FakeStreakRepository()
      ..getStreakResponse = const Left('streak error');
    final useCase = CheckStreakAndNotifyUseCase(
      notificationRepository,
      streakRepository,
    );

    final result = await useCase();

    expect(result, const Left('streak error'));
    expect(notificationRepository.shownId, isNull);
  });

  test('shows warning notification when last check-in is 20+ hours ago', () async {
    final notificationRepository = FakeNotificationRepository();
    final streakRepository = FakeStreakRepository()
      ..getStreakResponse = Right(
        StreakEntity(
          userId: 'u1',
          currentStreak: 5,
          longestStreak: 9,
          lastCheckInDate: DateTime.now().subtract(const Duration(hours: 21)),
        ),
      );
    final useCase = CheckStreakAndNotifyUseCase(
      notificationRepository,
      streakRepository,
    );

    final result = await useCase();

    expect(result, const Right(null));
    expect(notificationRepository.shownId, 103);
    expect(notificationRepository.shownTitle, NotificationStrings.streakWarningTitle);
    expect(notificationRepository.shownBody, NotificationStrings.streakWarningBody);
  });

  test('does not show notification when last check-in is recent', () async {
    final notificationRepository = FakeNotificationRepository();
    final streakRepository = FakeStreakRepository()
      ..getStreakResponse = Right(
        StreakEntity(
          userId: 'u1',
          currentStreak: 5,
          longestStreak: 9,
          lastCheckInDate: DateTime.now().subtract(const Duration(hours: 4)),
        ),
      );
    final useCase = CheckStreakAndNotifyUseCase(
      notificationRepository,
      streakRepository,
    );

    final result = await useCase();

    expect(result, const Right(null));
    expect(notificationRepository.shownId, isNull);
  });
}
