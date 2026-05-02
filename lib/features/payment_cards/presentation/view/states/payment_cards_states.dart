import 'package:finance_tracking/features/payment_cards/data/models/payment_card_model.dart';

sealed class PaymentCardsStates {}

class PaymentCardsInitial extends PaymentCardsStates {}

class PaymentCardsLoading extends PaymentCardsStates {}

class PaymentCardsSuccess extends PaymentCardsStates {
  final List<PaymentCardModel> cards;
  PaymentCardsSuccess({required this.cards});
}

class PaymentCardsError extends PaymentCardsStates {
  final String errorMessage;
  PaymentCardsError({required this.errorMessage});
}
