import 'package:finance_tracking/config/services/di_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/get_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';

class GetProfileNotifier extends Notifier<GetProfileStates> {
  GetProfileUseCase get _getProfileUseCase => getIt<GetProfileUseCase>();
  @override
  GetProfileStates build() {
    return GetProfileInitial();
  }

  Future<void> getProfile() async {
    
    state = GetProfileLoading();
    
    final result = await _getProfileUseCase.call();
    result.fold(
      (error) => state = GetProfileError(error: error),
      (profile) => state = GetProfileSuccess(userProfileEntity: profile),
    );
  }
}