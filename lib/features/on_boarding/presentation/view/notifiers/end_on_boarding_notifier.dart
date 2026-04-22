import 'package:finance_tracking/features/on_boarding/presentation/view/intents/end_on_boarding_intent.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/end_on_boarding_state.dart';
import '../../../domain/usecases/save_end_on_boarding_usecase.dart';

class EndOnBoardingNotifier extends Notifier<EndOnBoardingState> {
  final SaveEndOnBoardingUseCase _saveEndOnBoardingUseCase;

  EndOnBoardingNotifier(this._saveEndOnBoardingUseCase);

  @override
  EndOnBoardingState build() {
    return EndOnBoardingState(endOnBoarding: false);
  }

  Future<void> handleIntent(EndOnBoardingIntent intent) async {
    if (intent is EndOnBoardingSuccessIntent) {
      await _saveEndOnBoardingUseCase.execute(intent.value);
      state = state.copyWith(endOnBoarding: intent.value);
    }
  }
}
