import 'package:finance_tracking/features/security_and_biometrics/data/data_sources/biometrics_local_data_source.dart';
import 'package:finance_tracking/features/security_and_biometrics/data/data_sources/biometrics_platform_data_source.dart';
import 'package:finance_tracking/features/security_and_biometrics/domain/repositories/biometrics_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BiometricsRepositoryContract)
class BiometricsRepositoryImpl implements BiometricsRepositoryContract {
  final BiometricsLocalDataSource localDataSource;
  final BiometricsPlatformDataSource platformDataSource;

  BiometricsRepositoryImpl({
    required this.localDataSource,
    required this.platformDataSource,
  });

  @override
  Future<bool> isDeviceSupported() async {
    return await platformDataSource.isDeviceSupported();
  }

  @override
  Future<bool> authenticate(String localizedReason) async {
    return await platformDataSource.authenticate(localizedReason);
  }

  @override
  Future<void> setBiometricsEnabled(bool isEnabled) async {
    await localDataSource.setBiometricsEnabled(isEnabled);
  }

  @override
  bool isBiometricsEnabled() {
    return localDataSource.isBiometricsEnabled();
  }
}
