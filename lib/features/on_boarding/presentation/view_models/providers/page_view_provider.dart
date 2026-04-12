import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/notifiers/page_view_notifier.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/states/page_view_state.dart';

final pageViewProvider = NotifierProvider<PageViewNotifier, PageViewState>(
  () => PageViewNotifier(),
);