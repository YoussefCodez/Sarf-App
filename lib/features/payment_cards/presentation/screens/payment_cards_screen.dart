import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/payment_cards_strings.dart';
import 'package:finance_tracking/core/widgets/info_card.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/providers/payment_cards_provider.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/states/payment_cards_states.dart';
import 'package:finance_tracking/features/payment_cards/presentation/widgets/add_card_bottom_sheet.dart';
import 'package:finance_tracking/features/payment_cards/presentation/widgets/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PaymentCardsScreen extends ConsumerStatefulWidget {
  const PaymentCardsScreen({super.key});

  @override
  ConsumerState<PaymentCardsScreen> createState() => _PaymentCardsScreenState();
}

class _PaymentCardsScreenState extends ConsumerState<PaymentCardsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showAddCardSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddCardBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardsState = ref.watch(paymentCardsProvider);
    final cards = cardsState is PaymentCardsSuccess ? cardsState.cards : [];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
            size: 20.sp,
          ),
        ),
        title: Text(
          PaymentCardsStrings.myCards,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showAddCardSheet,
            icon: Icon(
              Icons.add_circle_outline,
              color: AppColors.primaryColor,
              size: 28.sp,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: cards.isEmpty
            ? Center(
                child: Text(
                  PaymentCardsStrings.noCardsFound,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(24.h),
                        SizedBox(
                          height: 240.h,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              ref
                                  .read(currentCardIndexProvider.notifier)
                                  .updateIndex(index);
                            },
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              final card = cards[index];
                              return AnimatedBuilder(
                                animation: _pageController,
                                builder: (context, child) {
                                  double value = 1.0;
                                  if (_pageController.position.haveDimensions) {
                                    value = _pageController.page! - index;
                                    value = (1 - (value.abs() * 0.2)).clamp(
                                      0.8,
                                      1.0,
                                    );
                                  }
                                  return Center(
                                    child: SizedBox(
                                      height:
                                          Curves.easeOut.transform(value) *
                                          220.h,
                                      width:
                                          Curves.easeOut.transform(value) *
                                          double.infinity,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: REdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: CreditCardWidget(
                                    cardNumber: card.cardNumber,
                                    cardHolder: card.cardHolder,
                                    expiryDate: card.expiryDate,
                                    baseColor: card.baseColor,
                                    brand: card.brand,
                                  ),
                                ),
                              );
                            },
                          ),
                        ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.1),
                        Gap(16.h),
                        Consumer(
                          builder: (context, ref, child) {
                            final currentIndex = ref.watch(
                              currentCardIndexProvider,
                            );
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                cards.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: REdgeInsets.symmetric(horizontal: 4),
                                  width: currentIndex == index ? 24.w : 8.w,
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                    color: currentIndex == index
                                        ? AppColors.primaryColor
                                        : AppColors.greyTextColor.withValues(
                                            alpha: 0.3,
                                          ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).animate().fadeIn(delay: 300.ms),
                        //Gap(32.h),
                        // Padding(
                        //   padding: REdgeInsets.symmetric(horizontal: 24),
                        //   child: Consumer(
                        //     builder: (context, ref, child) {
                        //       final currentIndex = ref.watch(currentCardIndexProvider);
                        //       final safeIndex = currentIndex < cards.length ? currentIndex : 0;
                        //       final currentCard = cards[safeIndex];
                        //       return Container(
                        //         width: double.infinity,
                        //         padding: REdgeInsets.all(20),
                        //         decoration: BoxDecoration(
                        //           color: AppColors.onScreenColor,
                        //           borderRadius: BorderRadius.circular(20.r),
                        //           border: Border.all(
                        //             color: AppColors.whiteColor.withValues(alpha: 0.05),
                        //           ),
                        //         ),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               PaymentCardsStrings.availableBalance,
                        //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        //                     color: AppColors.greyTextColor,
                        //                   ),
                        //             ),
                        //             Gap(8.h),
                        //             Text(
                        //               "EGP ${currentCard.balance.toStringAsFixed(2)}",
                        //               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        //                     color: AppColors.whiteColor,
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //             ),
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ).animate(target: 1.0).fadeIn(delay: 400.ms).slideY(begin: 0.1),
                        // ),
                        // Gap(24.h),
                        // Padding(
                        //   padding: REdgeInsets.symmetric(horizontal: 24),
                        //   child: Text(
                        //     PaymentCardsStrings.cardSettings,
                        //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        //       color: AppColors.whiteColor,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ).animate().fadeIn(delay: 500.ms),

                        // Gap(16.h),

                        // Consumer(
                        //   builder: (context, ref, child) {
                        //     final currentIndex = ref.watch(
                        //       currentCardIndexProvider,
                        //     );
                        //     final safeIndex = currentIndex < cards.length
                        //         ? currentIndex
                        //         : 0;
                        //     final currentCard = cards[safeIndex];
                        //     return Padding(
                        //       padding: REdgeInsets.symmetric(horizontal: 24),
                        //       child: Column(
                        //         children: [
                        //           // _buildSettingsTile(
                        //           //   icon: Icons.account_balance_wallet,
                        //           //   title: PaymentCardsStrings.manageBalance,
                        //           //   onTap: () => _showManageBalanceSheet(currentCard.id),
                        //           // ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                        // Gap(32.h),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 12,vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InfoCard(
                            title: 'Privacy',
                            subTitle:
                                "This card is only saved in your device and will be deleted if you delete the app , and we don't store any of your personal information",
                            svgPath: AppSvgs.privacy,
                            bgColor: AppColors.secondaryColor.withValues(
                              alpha: 0.2,
                            ),
                            iconBgColor: AppColors.secondaryColor.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
                  ),
                ],
              ),
      ),
    );
  }
}
