import 'package:local_auth/local_auth.dart';
import 'package:injectable/injectable.dart';

abstract class BiometricsPlatformDataSource {
  Future<bool> isDeviceSupported();
  Future<bool> authenticate(String localizedReason);
}

@LazySingleton(as: BiometricsPlatformDataSource)
class BiometricsPlatformDataSourceImpl implements BiometricsPlatformDataSource {
  final LocalAuthentication auth;

  BiometricsPlatformDataSourceImpl({required this.auth});

  @override
  Future<bool> isDeviceSupported() async {
    return await auth.isDeviceSupported() || await auth.canCheckBiometrics;
  }

  @override
  Future<bool> authenticate(String localizedReason) async {
    try {
      return await auth.authenticate(
        localizedReason: localizedReason,
      );
    } catch (e) {
      return false;
    }
  }
}
