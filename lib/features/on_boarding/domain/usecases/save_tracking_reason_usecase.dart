import 'package:injectable/injectable.dart';
import '../repositories/on_boarding_repository.dart';

@lazySingleton
class SaveTrackingReasonUseCase {
  final OnBoardingRepository _repository;

  SaveTrackingReasonUseCase(this._repository);

  Future<void> execute(bool value) async {
    return await _repository.saveTrackingReason(value);
  }
}
