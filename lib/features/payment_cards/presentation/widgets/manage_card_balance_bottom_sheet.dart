import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/payment_cards_strings.dart';
import 'package:finance_tracking/features/auth/presentation/view/providers/auth_provider.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/intents/payment_cards_intents.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/providers/payment_cards_provider.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/bottom_sheet_handle.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/transaction_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

//NOT USED YET

class ManageCardBalanceBottomSheet extends ConsumerStatefulWidget {
  final String cardId;
  const ManageCardBalanceBottomSheet({super.key, required this.cardId});

  @override
  ConsumerState<ManageCardBalanceBottomSheet> createState() => _ManageCardBalanceBottomSheetState();
}

class _ManageCardBalanceBottomSheetState extends ConsumerState<ManageCardBalanceBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  bool _isAdding = true;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_amountController.text.isEmpty) return;
    
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final userId = ref.read(currentUserIdProvider);
    ref.read(paymentCardsProvider.notifier).executeIntents(
      UpdateBalanceIntent(
        cardId: widget.cardId,
        amount: amount,
        isAdding: _isAdding,
        userId: userId,
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onScreenColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24.w,
        right: 24.w,
        top: 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetHandle(),
          Gap(24.h),
          Text(
            PaymentCardsStrings.manageBalanceTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gap(24.h),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text(PaymentCardsStrings.addPlus),
                  selected: _isAdding,
                  onSelected: (val) {
                    if (val) setState(() => _isAdding = true);
                  },
                  selectedColor: AppColors.primaryColor,
                  backgroundColor: AppColors.backgroundColor,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: ChoiceChip(
                  label: const Text(PaymentCardsStrings.deductMinus),
                  selected: !_isAdding,
                  onSelected: (val) {
                    if (val) setState(() => _isAdding = false);
                  },
                  selectedColor: AppColors.tertiaryColor,
                  backgroundColor: AppColors.backgroundColor,
                ),
              ),
            ],
          ),
          Gap(24.h),
          TransactionTextField(
            hintText: PaymentCardsStrings.enterAmount,
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          Gap(40.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                PaymentCardsStrings.confirm,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Gap(32.h),
        ],
      ),
    );
  }
}
