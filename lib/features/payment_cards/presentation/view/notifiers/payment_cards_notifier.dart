import 'package:finance_tracking/features/payment_cards/data/models/payment_card_model.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/intents/payment_cards_intents.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/states/payment_cards_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

import 'package:finance_tracking/features/auth/presentation/view/providers/auth_provider.dart';

class PaymentCardsNotifier extends Notifier<PaymentCardsStates> {
  Box<PaymentCardModel> get _box => Hive.box<PaymentCardModel>('payment_cards_box');

  @override
  PaymentCardsStates build() {
    final userId = ref.watch(currentUserIdProvider);
    final userCards = _box.values.where((card) => card.userId == userId).toList();
    return PaymentCardsSuccess(cards: userCards);
  }

  void executeIntents(PaymentCardsIntents intent) {
    if (intent is LoadCardsIntent) {
      _loadCards(intent.userId);
    } else if (intent is AddCardIntent) {
      _addCard(intent.card, intent.userId);
    } else if (intent is UpdateBalanceIntent) {
      _updateBalance(intent.cardId, intent.amount, intent.isAdding, intent.userId);
    }
  }

  void _loadCards(String userId) {
    state = PaymentCardsLoading();
    try {
      final userCards = _box.values.where((card) => card.userId == userId).toList();
      state = PaymentCardsSuccess(cards: userCards);
    } catch (e) {
      state = PaymentCardsError(errorMessage: "Failed to load cards");
    }
  }

  void _addCard(PaymentCardModel card, String userId) {
    if (state is PaymentCardsSuccess) {
      final currentState = state as PaymentCardsSuccess;
      _box.put(card.id, card);
      state = PaymentCardsSuccess(cards: [...currentState.cards, card]);
    } else {
      _box.put(card.id, card);
      _loadCards(userId);
    }
  }

  void _updateBalance(String cardId, double amount, bool isAdding, String userId) {
    if (state is PaymentCardsSuccess) {
      final currentState = state as PaymentCardsSuccess;
      final card = _box.get(cardId);
      if (card != null && card.userId == userId) {
        final newBalance = isAdding ? card.balance + amount : card.balance - amount;
        final updatedCard = card.copyWith(balance: newBalance >= 0 ? newBalance : 0.0);
        _box.put(cardId, updatedCard);
        
        final updatedList = currentState.cards.map((c) => c.id == cardId ? updatedCard : c).toList();
        state = PaymentCardsSuccess(cards: updatedList);
      }
    }
  }
}
