import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/config/services/app_services.dart';
import 'package:finance_tracking/config/services/di_service.dart';
import 'package:finance_tracking/core/theme/app_theme.dart';
import 'package:finance_tracking/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quick_actions/quick_actions.dart';

void main() async {
  await AppServices.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    showItems();
    navigate();
  }
  final QuickActions quickActions = getIt<QuickActions>();
  void showItems() {
    quickActions.setShortcutItems([
      const ShortcutItem(
        type: 'add_transaction',
        localizedTitle: 'Add Transaction',
        icon: 'plus'
      ),
    ]);
  }

  void navigate() {
    quickActions.initialize((type) {
      switch (type) {
        case 'add_transaction':
          AppRouter.router.go('${AppRoutes.homeScreen}?shortcut=true');
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          routerConfig: AppRouter.router,
          scrollBehavior: MyScrollBehavior(),
        );
      },
    );
  }
}
