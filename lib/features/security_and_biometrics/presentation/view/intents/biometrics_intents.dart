abstract class BiometricsIntent {}

class GetBiometricsStatusIntent extends BiometricsIntent {}

class ToggleBiometricsIntent extends BiometricsIntent {
  final bool enable;
  final String localizedReason;
  ToggleBiometricsIntent({required this.enable, required this.localizedReason});
}

class AuthenticateToAccessAppIntent extends BiometricsIntent {
  final String localizedReason;
  AuthenticateToAccessAppIntent({required this.localizedReason});
}
