import 'package:finance_tracking/features/daily_advice/domain/entities/user_finance_entity.dart';

/// Base interface for the Strategy Pattern / Rule Engine
abstract class AdviceRule {
  /// Defines if a rule is applicable to the user's current situation.
  bool isApplicable(UserFinanceEntity financeData);

  /// Executes the business logic and returns a meaningful string.
  String generateAdvice(UserFinanceEntity financeData);
}
