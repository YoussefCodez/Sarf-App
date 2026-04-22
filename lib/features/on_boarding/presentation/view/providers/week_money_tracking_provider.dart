import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/notifiers/week_money_tracking_notifier.dart';

final weekMoneyTrackingNotifierProvider = NotifierProvider<WeekMoneyTrackingNotifier, double>(
  WeekMoneyTrackingNotifier.new,
);