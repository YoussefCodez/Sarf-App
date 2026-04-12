import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/page_view_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/states/page_view_state.dart';

class PageViewNotifier extends Notifier<PageViewState> {
  late final PageController pageController;

  @override
  PageViewState build() {
    pageController = PageController(initialPage: 0);
    return PageViewState(pageIndex: 0, totalPages: 3);
  }

  void handleIntent(PageViewIntent intent) {
    switch (intent) {
      case NextPageIntent():
        nextPage();
        break;
      case PreviousPageIntent():
        previousPage();
        break;
    }
  }

  void nextPage() {
    final current = state.pageIndex;
    if (current < state.totalPages - 1) {
      pageController.animateToPage(
        current + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      state = state.copyWith(pageIndex: current + 1);
    }
  }

  void previousPage() {
    if (state.pageIndex > 0) {
      state = state.copyWith(pageIndex: state.pageIndex - 1);
    }
  }
}