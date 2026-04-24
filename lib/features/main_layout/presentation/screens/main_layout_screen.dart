import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/home/presentation/screens/home_screen.dart';
import 'package:finance_tracking/features/main_layout/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}


class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text("Transactions", style: TextStyle(color: Colors.white, fontSize: 24))),
    const SizedBox.shrink(), // Placeholder for index 2 (Add Button)
    const Center(child: Text("Wallet", style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
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
                    backgroundColor: AppColors.secondCardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    builder: (context) {
                      final height = MediaQuery.of(context).size.height;
                      return Container(
                        height: height * 0.5,
                        padding: const EdgeInsets.all(24),
                        child: Column(), //TODO: Add transaction form
                      );
                    },
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
