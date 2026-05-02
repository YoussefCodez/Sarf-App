import 'package:finance_tracking/core/app_strings/biometrics_strings.dart';
import 'package:finance_tracking/features/home/presentation/screens/home_screen.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/intents/biometrics_intents.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/providers/biometrics_provider.dart';
import 'package:finance_tracking/features/security_and_biometrics/presentation/view/states/biometrics_states.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/add_transaction_bottom_sheet.dart';
import 'package:finance_tracking/features/main_layout/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:finance_tracking/features/main_layout/presentation/widgets/lock_screen_body.dart';
import 'package:finance_tracking/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainLayoutScreen extends ConsumerStatefulWidget {
  final bool shortcut;
  const MainLayoutScreen({super.key, this.shortcut = false});

  @override
  ConsumerState<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends ConsumerState<MainLayoutScreen>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  bool _isLocked = true;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authenticateIfNeeded();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (!_isAuthenticating) {
        setState(() {
          _isLocked = true;
        });
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_isLocked && !_isAuthenticating) {
        _authenticateIfNeeded();
      }
    }
  }

  void _authenticateIfNeeded() {
    if (_isAuthenticating) return;
    _isAuthenticating = true;
    ref.read(biometricsProvider.notifier).handleIntent(
          AuthenticateToAccessAppIntent(
            localizedReason: BiometricsStrings.pleaseAuthenticate,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(syncProvider);
    ref.listen(biometricsProvider, (previous, next) {
      if (next is BiometricsAuthSuccess ||
          next is BiometricsAuthFailed ||
          next is BiometricsError) {
        _isAuthenticating = false;
      }
    });

    final biometricsState = ref.watch(biometricsProvider);

    if (biometricsState is BiometricsAuthSuccess) {
      _isLocked = false;
    } else if (biometricsState is BiometricsAuthFailed ||
        biometricsState is BiometricsError) {
      _isLocked = true;
    }

    if (_isLocked) {
      return LockScreenBody(onUnlockPressed: _authenticateIfNeeded);
    }

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              HomeScreen(shortcut: widget.shortcut),
              const Center(
                child: Text(
                  "Transactions",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              const SizedBox.shrink(),
              const Center(
                child: Text(
                  "Wallet",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              const SettingsScreen(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == 2) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const AddTransactionBottomSheet(),
                  );
                } else {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
