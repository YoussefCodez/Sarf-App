import 'package:injectable/injectable.dart';
import '../repositories/on_boarding_repository.dart';

@LazySingleton()
class SaveEndOnBoardingUseCase {
  final OnBoardingRepository _repository;

  SaveEndOnBoardingUseCase(this._repository);

  Future<void> execute(bool value) async {
    await _repository.saveEndOnBoarding(value);
  }
}