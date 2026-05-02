import 'package:local_auth/local_auth.dart';

class BiometricsService {
  final LocalAuthentication _localAuthentication;

  BiometricsService(this._localAuthentication);

  Future<bool> isBiometricsAvailable() async {
    return await _localAuthentication.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    return await _localAuthentication.authenticate(
      localizedReason: 'Please authenticate to access the app',
    );
  }
}

