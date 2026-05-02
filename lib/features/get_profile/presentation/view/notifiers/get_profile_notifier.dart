import 'package:finance_tracking/config/services/di_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/get_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/intents/get_profile_intent.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';

class GetProfileNotifier extends Notifier<GetProfileStates> {
  GetProfileUseCase get _getProfileUseCase => getIt<GetProfileUseCase>();
  @override
  GetProfileStates build() {
    return GetProfileInitial();
  }

  Future<void> handleIntent(GetProfileIntent intent) async {
    switch (intent) {
      case GetProfileIntentImpl():
        await getProfile();
        break;
    }
  }

  Future<void> getProfile() async {
    state = GetProfileLoading();

    final result = await _getProfileUseCase.call();
    result.fold(
      (error) => state = GetProfileError(error: error),
      (profile) => state = GetProfileSuccess(userProfileEntity: profile),
    );
  }

  void updateBalance(double amount, String type) {
    if (state is GetProfileSuccess) {
      final currentProfile = (state as GetProfileSuccess).userProfileEntity;
      final double currentMoney = double.tryParse(currentProfile.currentMoney) ?? 0.0;
      final double newMoney = type.toLowerCase() == 'income' 
          ? currentMoney + amount 
          : currentMoney - amount;

      state = GetProfileSuccess(
        userProfileEntity: currentProfile.copyWith(currentMoney: newMoney.toString()),
      );
    }
  }
}
