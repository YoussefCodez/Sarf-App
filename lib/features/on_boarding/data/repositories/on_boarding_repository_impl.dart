import 'package:injectable/injectable.dart';
import '../../domain/repositories/on_boarding_repository.dart';
import '../datasources/on_boarding_local_datasource.dart';

@LazySingleton(as: OnBoardingRepository)
class OnBoardingRepositoryImpl implements OnBoardingRepository {
  final OnBoardingLocalDataSource _localDataSource;

  OnBoardingRepositoryImpl(this._localDataSource);

  @override
  Future<void> saveTrackingReason(bool value) async {
    await _localDataSource.saveTrackingReason(value);
  }

  @override
  Future<void> saveWeeklySpending(double value) async {
    await _localDataSource.saveWeeklySpending(value);
  }
}
