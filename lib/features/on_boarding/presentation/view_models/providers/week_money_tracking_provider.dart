import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/notifiers/week_money_tracking_notifier.dart';

final weekMoneyTrackingNotifierProvider = NotifierProvider<WeekMoneyTrackingNotifier, double>(
  WeekMoneyTrackingNotifier.new,
);