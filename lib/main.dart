import 'package:finance_tracking/config/services/app_services.dart';
import 'package:finance_tracking/core/theme/app_theme.dart';
import 'package:finance_tracking/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await AppServices.init();
  runApp(ProviderScope(child: const MyApp()));
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
  const MyApp({super.key});
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
