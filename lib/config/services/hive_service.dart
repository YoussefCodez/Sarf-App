import 'package:finance_tracking/features/payment_cards/data/models/payment_card_model.dart';
import 'package:finance_tracking/hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class HiveService {
  /// Initializes Hive and opens necessary boxes.
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters via generated registrar
    Hive.registerAdapters();
    
    // Open static boxes
    await Hive.openBox('settings_box');
    await Hive.openBox<PaymentCardModel>('payment_cards_box');
  }
}
