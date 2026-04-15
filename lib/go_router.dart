import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/features/auth/presentation/screens/login_screen.dart';
import 'package:finance_tracking/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:finance_tracking/features/home/home_screen.dart';
import 'package:finance_tracking/features/on_boarding/data/datasources/on_boarding_local_datasource.dart';
import 'package:finance_tracking/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppRouter {
  static final supabaseClient = getIt<SupabaseClient>();
  static final GoRouter router = GoRouter(
    initialLocation: getIt<OnBoardingLocalDataSource>().getEndOnBoarding()
        ? supabaseClient.auth.currentUser != null
            ? AppRoutes.homeScreen
            : AppRoutes.loginScreen
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
      GoRoute(
        path: AppRoutes.loginScreen,
        builder: (context, state) {
          final bool backToSignUp = state.uri.queryParameters['backToSignUp'] == 'true';
          return LoginScreen(backToSignUp: backToSignUp);
        },
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}