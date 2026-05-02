import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/goal_tracker_notifier.dart';
import '../states/goal_tracker_states.dart';

final goalTrackerProvider = NotifierProvider<GoalTrackerNotifier, GoalTrackerState>(() {
  return GoalTrackerNotifier();
});

