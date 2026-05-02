abstract class BiometricsState {}

class BiometricsInitial extends BiometricsState {}

class BiometricsLoading extends BiometricsState {}

class BiometricsStatusLoaded extends BiometricsState {
  final bool isEnabled;
  BiometricsStatusLoaded(this.isEnabled);
}

class BiometricsAuthSuccess extends BiometricsState {
  final bool newStatus;
  BiometricsAuthSuccess(this.newStatus);
}

class BiometricsAuthFailed extends BiometricsState {}

class BiometricsError extends BiometricsState {
  final String message;
  BiometricsError(this.message);
}
