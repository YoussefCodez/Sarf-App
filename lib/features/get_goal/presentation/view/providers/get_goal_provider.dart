import 'package:finance_tracking/features/get_goal/presentation/view/notifiers/get_goal_notifier.dart';
import 'package:finance_tracking/features/get_goal/presentation/view/states/get_goal_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getGoalProvider = NotifierProvider<GetGoalNotifier, GetGoalStates>(
  GetGoalNotifier.new,
);
