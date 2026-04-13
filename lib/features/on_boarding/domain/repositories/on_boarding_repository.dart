abstract interface class OnBoardingRepository {
  Future<void> saveTrackingReason(bool value);
  Future<void> saveWeeklySpending(double value);
}
