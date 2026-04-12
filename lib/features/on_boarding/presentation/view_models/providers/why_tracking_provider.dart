import 'package:finance_tracking/features/on_boarding/presentation/view_models/notifiers/why_tracking_notifier.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/states/why_tracking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final whyTrackingNotifierProvider = NotifierProvider<WhyTrackingNotifier, WhyTrackingState>(
  WhyTrackingNotifier.new,
);