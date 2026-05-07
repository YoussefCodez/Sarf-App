import 'package:dartz/dartz.dart';
import 'package:finance_tracking/core/app_strings/notification_strings.dart';
import 'package:finance_tracking/features/notifications/domain/repositories/notification_repository.dart';
import 'package:finance_tracking/features/streak/domain/repositories/streak_repository_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CheckStreakAndNotifyUseCase {
  final NotificationRepository _notificationRepository;
  final StreakRepositoryContract _streakRepository;

  CheckStreakAndNotifyUseCase(
    this._notificationRepository,
    this._streakRepository,
  );

  Future<Either<String, void>> call() async {
    final streakResult = await _streakRepository.getStreak();

    return streakResult.fold(
      (error) => Left(error),
      (streak) async {
        final now = DateTime.now();
        final hoursSinceLastCheckIn = now.difference(streak.lastCheckInDate).inHours;

        if (hoursSinceLastCheckIn >= 20) {
          return _notificationRepository.showInstantNotification(
            id: 103,
            title: NotificationStrings.streakWarningTitle,
            body: NotificationStrings.streakWarningBody,
          );
        }
        return const Right(null);
      },
    );
  }
}
