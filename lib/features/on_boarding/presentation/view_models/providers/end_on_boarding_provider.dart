import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/on_boarding/domain/usecases/save_end_on_boarding_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/end_on_boarding_notifier.dart';
import '../states/end_on_boarding_state.dart';

final endOnBoardingProvider = NotifierProvider<EndOnBoardingNotifier, EndOnBoardingState>(
  () => EndOnBoardingNotifier(getIt<SaveEndOnBoardingUseCase>()),
);