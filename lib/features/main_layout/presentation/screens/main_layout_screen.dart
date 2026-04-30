import 'package:finance_tracking/features/home/presentation/screens/home_screen.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/add_transaction_bottom_sheet.dart';
import 'package:finance_tracking/features/main_layout/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainLayoutScreen extends ConsumerStatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  ConsumerState<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends ConsumerState<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
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
    const Center(
      child: Text(
        "Profile",
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(syncProvider);

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _pages),
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
