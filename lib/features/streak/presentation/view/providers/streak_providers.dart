import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/streak/domain/use_cases/get_streak_usecase.dart';
import 'package:finance_tracking/features/streak/domain/use_cases/record_check_in_usecase.dart';
import 'package:finance_tracking/features/streak/presentation/view/notifiers/streak_notifier.dart';
import 'package:finance_tracking/features/streak/presentation/view/states/streak_states.dart';
import 'package:flutter_riverpod/legacy.dart';

final streakProvider =
    StateNotifierProvider<StreakNotifier, StreakState>((ref) {
      return StreakNotifier(
        getStreakUseCase: getIt<GetStreakUseCase>(),
        recordCheckInUseCase: getIt<RecordCheckInUseCase>(),
      );
    });
