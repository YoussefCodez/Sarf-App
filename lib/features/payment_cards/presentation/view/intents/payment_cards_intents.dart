import 'package:finance_tracking/features/payment_cards/data/models/payment_card_model.dart';

sealed class PaymentCardsIntents {}

class LoadCardsIntent extends PaymentCardsIntents {
  final String userId;
  LoadCardsIntent({required this.userId});
}

class AddCardIntent extends PaymentCardsIntents {
  final PaymentCardModel card;
  final String userId;
  AddCardIntent({required this.card, required this.userId});
}

class UpdateBalanceIntent extends PaymentCardsIntents {
  final String cardId;
  final double amount;
  final bool isAdding;
  final String userId;
  UpdateBalanceIntent({
    required this.cardId,
    required this.amount,
    required this.isAdding,
    required this.userId,
  });
}
