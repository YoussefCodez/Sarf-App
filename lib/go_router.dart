import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onBoardingScreen,
    routes: [
      GoRoute(
        path: AppRoutes.onBoardingScreen,
        builder: (context, state) => const OnBoardingScreen(),
      ),
    ],
  );
}