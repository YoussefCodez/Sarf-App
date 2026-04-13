import 'package:injectable/injectable.dart';
import '../repositories/on_boarding_repository.dart';

@lazySingleton
class SaveWeeklySpendingUseCase {
  final OnBoardingRepository _repository;

  SaveWeeklySpendingUseCase(this._repository);

  Future<void> execute(double value) async {
    await _repository.saveWeeklySpending(value);
  }
}
