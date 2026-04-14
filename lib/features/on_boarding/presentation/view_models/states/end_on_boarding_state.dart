class EndOnBoardingState {
  final bool endOnBoarding;

  EndOnBoardingState({required this.endOnBoarding});

  EndOnBoardingState copyWith({bool? endOnBoarding}) {
    return EndOnBoardingState(
      endOnBoarding: endOnBoarding ?? this.endOnBoarding,
    );
  }
}
  