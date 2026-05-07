import 'package:finance_tracking/features/streak/domain/use_cases/get_streak_usecase.dart';
import 'package:finance_tracking/features/streak/domain/use_cases/record_check_in_usecase.dart';
import 'package:finance_tracking/features/streak/presentation/view/intents/streak_intents.dart';
import 'package:finance_tracking/features/streak/presentation/view/states/streak_states.dart';
import 'package:flutter_riverpod/legacy.dart';

class StreakNotifier extends StateNotifier<StreakState> {
  final GetStreakUseCase getStreakUseCase;
  final RecordCheckInUseCase recordCheckInUseCase;

  StreakNotifier({
    required this.getStreakUseCase,
    required this.recordCheckInUseCase,
  }) : super(StreakInitial());

  Future<void> handleIntent(StreakIntent intent) async {
    if (intent is GetStreakIntent) {
      state = StreakLoading();

      final result = await getStreakUseCase();

      result.fold(
        (failure) => state = StreakError(failure),
        (streak) => state = StreakSuccess(streak),
      );
    } else if (intent is RecordCheckInIntent) {
      state = StreakLoading();

      final result = await recordCheckInUseCase();

      result.fold(
        (failure) => state = StreakError(failure),
        (streak) => state = StreakSuccess(streak),
      );
    }
  }
}
