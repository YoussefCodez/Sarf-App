import 'package:dartz/dartz.dart';
import 'package:finance_tracking/config/services/network_info_service.dart';
import 'package:finance_tracking/config/services/supabase_error_handler_service.dart';
import 'package:finance_tracking/config/utils/out_put_print_util.dart';
import 'package:finance_tracking/features/streak/data/data_source/streak_local_data_source.dart';
import 'package:finance_tracking/features/streak/data/data_source/streak_remote_data_source.dart';
import 'package:finance_tracking/features/streak/domain/entities/streak_entity.dart';
import 'package:finance_tracking/features/streak/domain/repositories/streak_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: StreakRepositoryContract)
class StreakRepositoryImpl implements StreakRepositoryContract {
  final StreakRemoteDataSource remoteDataSource;
  final StreakLocalDataSource localDataSource;
  final SupabaseErrorHandlerService supabaseErrorHandlerService;
  final NetworkInfo networkInfo;

  StreakRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.supabaseErrorHandlerService,
    required this.networkInfo,
  });

  @override
  Future<Either<String, StreakEntity>> getStreak() async {
    try {
      final bool isOnline = await networkInfo.isConnected;
      if (isOnline) {
        final streak = await remoteDataSource.getStreak();
        await localDataSource.saveStreak(
          currentStreak: streak.currentStreak,
          longestStreak: streak.longestStreak,
          lastCheckInDate: streak.lastCheckInDate,
        );
        return Right(streak);
      } else {
        final localStreak = await localDataSource.getStreak();
        if (localStreak != null) {
          return Right(localStreak);
        }
        return Right(
          StreakEntity(
            userId: '',
            currentStreak: 0,
            longestStreak: 0,
            lastCheckInDate: DateTime.now().toUtc(),
          ),
        );
      }
    } catch (e) {
      printOutPut(e);
      final localStreak = await localDataSource.getStreak();
      if (localStreak != null) {
        return Right(localStreak);
      }
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }

  @override
  Future<Either<String, StreakEntity>> recordCheckIn() async {
    try {
      final bool isOnline = await networkInfo.isConnected;
      final String userId = remoteDataSource.getUserId();

      if (isOnline) {
        final DateTime serverNow = await _getServerTime();
        final DateTime todayUtc = DateTime.utc(serverNow.year, serverNow.month, serverNow.day);

        final existingStreak = await remoteDataSource.getStreak();

        final DateTime lastCheckInDay = DateTime.utc(
          existingStreak.lastCheckInDate.year,
          existingStreak.lastCheckInDate.month,
          existingStreak.lastCheckInDate.day,
        );

        final int daysDifference = todayUtc.difference(lastCheckInDay).inDays;

        if (daysDifference == 0 && existingStreak.currentStreak > 0) {
          await localDataSource.saveStreak(
            currentStreak: existingStreak.currentStreak,
            longestStreak: existingStreak.longestStreak,
            lastCheckInDate: existingStreak.lastCheckInDate,
          );
          return Right(existingStreak);
        }

        final int newStreak;
        if (daysDifference == 1) {
          newStreak = existingStreak.currentStreak + 1;
        } else {
          newStreak = 1;
        }

        final int newLongest = newStreak > existingStreak.longestStreak
            ? newStreak
            : existingStreak.longestStreak;

        await remoteDataSource.updateStreak(
          currentStreak: newStreak,
          longestStreak: newLongest,
          lastCheckInDate: todayUtc,
        );

        await localDataSource.saveStreak(
          currentStreak: newStreak,
          longestStreak: newLongest,
          lastCheckInDate: todayUtc,
        );

        return Right(
          StreakEntity(
            userId: userId,
            currentStreak: newStreak,
            longestStreak: newLongest,
            lastCheckInDate: todayUtc,
          ),
        );
      } else {
        final localStreak = await localDataSource.getStreak();

        final DateTime nowUtc = DateTime.now().toUtc();
        final DateTime todayUtc = DateTime.utc(nowUtc.year, nowUtc.month, nowUtc.day);

        if (localStreak == null || localStreak.currentStreak == 0) {
          await localDataSource.saveStreak(
            currentStreak: 1,
            longestStreak: 1,
            lastCheckInDate: todayUtc,
          );
          return Right(
            StreakEntity(
              userId: userId,
              currentStreak: 1,
              longestStreak: 1,
              lastCheckInDate: todayUtc,
            ),
          );
        }

        final DateTime lastCheckInDay = DateTime.utc(
          localStreak.lastCheckInDate.year,
          localStreak.lastCheckInDate.month,
          localStreak.lastCheckInDate.day,
        );

        final int daysDifference = todayUtc.difference(lastCheckInDay).inDays;

        if (daysDifference == 0) {
          return Right(localStreak);
        }

        final int newStreak;
        if (daysDifference == 1) {
          newStreak = localStreak.currentStreak + 1;
        } else {
          newStreak = 1;
        }

        final int newLongest = newStreak > localStreak.longestStreak
            ? newStreak
            : localStreak.longestStreak;

        await localDataSource.saveStreak(
          currentStreak: newStreak,
          longestStreak: newLongest,
          lastCheckInDate: todayUtc,
        );

        return Right(
          StreakEntity(
            userId: localStreak.userId,
            currentStreak: newStreak,
            longestStreak: newLongest,
            lastCheckInDate: todayUtc,
          ),
        );
      }
    } catch (e) {
      printOutPut(e);
      return Left(supabaseErrorHandlerService.handle(e));
    }
  }

  Future<DateTime> _getServerTime() async {
    try {
      return await remoteDataSource.getServerTimestamp();
    } catch (_) {
      return DateTime.now().toUtc();
    }
  }
}
