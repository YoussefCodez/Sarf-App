import 'package:finance_tracking/core/app_assets/app_images.dart';
import 'package:finance_tracking/core/app_assets/app_svgs.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/payment_cards/data/models/payment_card_model.dart';
import 'package:finance_tracking/core/app_strings/payment_cards_strings.dart';
import 'package:finance_tracking/features/payment_cards/presentation/widgets/emv_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class CreditCardWidget extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final Color baseColor;
  final CardBrand brand;

  const CreditCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.baseColor,
    required this.brand,
  });

  Widget _buildBrandLogo() {
    switch (brand) {
      case CardBrand.visa:
        return SvgPicture.asset(AppSvgs.visa, width: 50.w, height: 30.h);
      case CardBrand.mastercard:
        return SvgPicture.asset(AppSvgs.masterCard, width: 50.w, height: 30.h);
      case CardBrand.meeza:
        return Image.asset(AppImages.meeza, width: 50.w, height: 30.h);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.h,
      padding: REdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            baseColor.withValues(alpha: 0.9),
            baseColor.withValues(alpha: 0.6),
            baseColor.withValues(alpha: 0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: AppColors.whiteColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50.w,
            top: -50.h,
            child: Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            left: -30.w,
            bottom: -50.h,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const EmvChipWidget(),
                  Transform.rotate(
                    angle: math.pi / 2,
                    child: Icon(
                      Icons.wifi,
                      color: AppColors.whiteColor.withValues(alpha: 0.8),
                      size: 28.sp,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardNumber,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.whiteColor,
                          letterSpacing: 4.w,
                          fontFamily: 'Courier',
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PaymentCardsStrings.cardHolder,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.whiteColor.withValues(alpha: 0.6),
                                  fontSize: 10.sp,
                                ),
                          ),
                          Gap(4.h),
                          Text(
                            cardHolder.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PaymentCardsStrings.expires,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.whiteColor.withValues(alpha: 0.6),
                                  fontSize: 10.sp,
                                ),
                          ),
                          Gap(4.h),
                          Text(
                            expiryDate,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      _buildBrandLogo(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
