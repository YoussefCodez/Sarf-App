sealed class EndOnBoardingIntent {}

class EndOnBoardingSuccessIntent extends EndOnBoardingIntent {
  final bool value;

  EndOnBoardingSuccessIntent(this.value);
}