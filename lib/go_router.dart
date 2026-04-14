import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:finance_tracking/features/on_boarding/data/datasources/on_boarding_local_datasource.dart';
import 'package:finance_tracking/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: getIt<OnBoardingLocalDataSource>().getEndOnBoarding()
        ? AppRoutes.signUpScreen
        : AppRoutes.onBoardingScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onBoardingScreen,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(  
        path: AppRoutes.signUpScreen,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}