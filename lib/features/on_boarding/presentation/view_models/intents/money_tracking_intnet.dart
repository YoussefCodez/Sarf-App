sealed class MoneyTrackingIntent {}

class MoneyTrackingIntentUpdate extends MoneyTrackingIntent {
  final double weekMoneyTracking;

  MoneyTrackingIntentUpdate({required this.weekMoneyTracking});
}

class MoneyTrackingIntentFinish extends MoneyTrackingIntent {}

class MoneyTrackingIntentSkip extends MoneyTrackingIntent {}