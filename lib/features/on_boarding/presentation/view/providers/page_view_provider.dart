import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/notifiers/page_view_notifier.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/states/page_view_state.dart';

final pageViewProvider = NotifierProvider<PageViewNotifier, PageViewState>(
  () => PageViewNotifier(),
);