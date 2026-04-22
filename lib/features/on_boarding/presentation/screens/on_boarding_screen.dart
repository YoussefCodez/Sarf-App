import 'package:finance_tracking/features/on_boarding/presentation/view/providers/page_view_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/on_boarding_page_one.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/on_boarding_page_three.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/on_boarding_page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            return PageView(
              controller: ref.watch(pageViewProvider.notifier).pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                OnBoardingPageOne(),
                OnBoardingPageTwo(),
                OnBoardingPageThree(),
              ],
            );
          },
        ),
      ),
    );
  }
}