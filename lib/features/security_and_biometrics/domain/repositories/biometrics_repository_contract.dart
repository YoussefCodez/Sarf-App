abstract class BiometricsRepositoryContract {
  Future<bool> isDeviceSupported();
  Future<bool> authenticate(String localizedReason);
  Future<void> setBiometricsEnabled(bool isEnabled);
  bool isBiometricsEnabled();
}
