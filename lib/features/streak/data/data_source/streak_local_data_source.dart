import 'package:finance_tracking/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';
import 'package:injectable/injectable.dart';

abstract interface class StreakLocalDataSource {
  Future<StreakEntity?> getStreak();
  Future<void> saveStreak({
    required int currentStreak,
    required int longestStreak,
    required DateTime lastCheckInDate,
  });
}

@LazySingleton(as: StreakLocalDataSource)
class StreakLocalDataSourceImpl implements StreakLocalDataSource {
  final AuthLocalDataSource _authLocalDataSource;

  StreakLocalDataSourceImpl(this._authLocalDataSource);

  @override
  Future<StreakEntity?> getStreak() async {
    final profile = await _authLocalDataSource.getUserProfile();
    if (profile == null) return null;
    return StreakEntity(
      userId: profile.id,
      currentStreak: profile.currentStreak,
      longestStreak: profile.longestStreak,
      lastCheckInDate: profile.lastCheckInDate ?? DateTime.now().toUtc(),
    );
  }

  @override
  Future<void> saveStreak({
    required int currentStreak,
    required int longestStreak,
    required DateTime lastCheckInDate,
  }) async {
    final profile = await _authLocalDataSource.getUserProfile();
    if (profile == null) return;
    final updated = profile.copyWith(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastCheckInDate: lastCheckInDate,
    );
    await _authLocalDataSource.saveUserProfile(updated);
  }
}
