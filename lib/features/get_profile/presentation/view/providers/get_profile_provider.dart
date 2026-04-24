import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/notifiers/get_profile_notifier.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';

final getProfileProvider = NotifierProvider<GetProfileNotifier, GetProfileStates>(
  GetProfileNotifier.new,
);