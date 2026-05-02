import 'package:finance_tracking/features/payment_cards/data/models/payment_card_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:finance_tracking/features/payment_cards/presentation/view/notifiers/payment_cards_notifier.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/states/payment_cards_states.dart';

class CurrentCardIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void updateIndex(int newIndex) {
    state = newIndex;
  }
}

final currentCardIndexProvider = NotifierProvider<CurrentCardIndexNotifier, int>(() {
  return CurrentCardIndexNotifier();
});

class SelectedBrandNotifier extends Notifier<CardBrand> {
  @override
  CardBrand build() => CardBrand.mastercard;

  void select(CardBrand brand) => state = brand;
}

final selectedBrandProvider = NotifierProvider<SelectedBrandNotifier, CardBrand>(() {
  return SelectedBrandNotifier();
});

final paymentCardsProvider = NotifierProvider<PaymentCardsNotifier, PaymentCardsStates>(() {
  return PaymentCardsNotifier();
});
