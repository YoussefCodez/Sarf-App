import 'package:finance_tracking/config/const/app_const.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/intents/money_tracking_intnet.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view/providers/week_money_tracking_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/spend_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SpendChipsRow extends StatelessWidget {
  const SpendChipsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final weekMoneyTracking = ref.watch(weekMoneyTrackingNotifierProvider);
        return Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          alignment: WrapAlignment.center,
          children: AppConst.weekSpendAmountsChips.map((amount) {
            return SpendChipWidget(
              amount: amount,
              isSelected: weekMoneyTracking == double.parse(amount),
              onPressed: () {
                ref
                    .read(weekMoneyTrackingNotifierProvider.notifier)
                    .handleIntent(
                      MoneyTrackingIntentUpdate(
                        weekMoneyTracking: double.parse(amount),
                      ),
                    );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
