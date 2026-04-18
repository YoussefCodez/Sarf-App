import 'package:finance_tracking/app_routes.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/intents/auth_intent.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/providers/auth_provider.dart';
import 'package:finance_tracking/features/auth/presentation/view_models/states/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          // Listen to auth state to navigate back on logout
          ref.listen(authNotifierProvider, (previous, next) {
            if (next is AuthInitial) {
              context.go(AppRoutes.loginScreen);
            }
          });

          return Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).handleIntent(LogoutIntent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Sign Out'),
            ),
          );
        },
      ),
    );
  }
}