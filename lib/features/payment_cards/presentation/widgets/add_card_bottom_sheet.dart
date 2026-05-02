import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/payment_cards_strings.dart';
import 'package:finance_tracking/features/auth/presentation/view/providers/auth_provider.dart';
import 'package:finance_tracking/features/payment_cards/data/models/payment_card_model.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/intents/payment_cards_intents.dart';
import 'package:finance_tracking/features/payment_cards/presentation/view/providers/payment_cards_provider.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/bottom_sheet_handle.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/transaction_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:finance_tracking/config/utils/input_formatters.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

class AddCardBottomSheet extends ConsumerStatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  ConsumerState<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends ConsumerState<AddCardBottomSheet> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();


  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _submitCard() {
    if (_cardNumberController.text.isEmpty ||
        _cardHolderController.text.isEmpty) {
      return;
    }

    final newCard = PaymentCardModel(
      id: const Uuid().v4(),
      cardNumber: _cardNumberController.text,
      cardHolder: _cardHolderController.text,
      expiryDate: _expiryController.text.isEmpty
          ? '12/28'
          : _expiryController.text,
      baseColorValue: AppColors.primaryColor.toARGB32(),
      brand: ref.read(selectedBrandProvider),
      balance: double.tryParse(_balanceController.text) ?? 0.0,
      userId: ref.read(currentUserIdProvider),
    );

    ref.read(paymentCardsProvider.notifier).executeIntents(AddCardIntent(card: newCard, userId: newCard.userId));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final selectedBrand = ref.watch(selectedBrandProvider);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.onScreenColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            Gap(16.h),
            const BottomSheetHandle(),
            Gap(16.h),
            Expanded(
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      PaymentCardsStrings.addNewCard,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(24.h),
                    TransactionTextField(
                      hintText: PaymentCardsStrings.cardNumberHint,
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CardNumberInputFormatter(),
                      ],
                    ),
                    Gap(16.h),
                    TransactionTextField(
                      hintText: PaymentCardsStrings.cardHolderHint,
                      controller: _cardHolderController,
                    ),
                    Gap(16.h),
                    Row(
                      children: [
                        Expanded(
                          child: TransactionTextField(
                            hintText: PaymentCardsStrings.expiryHint,
                            controller: _expiryController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              ExpiryDateInputFormatter(),
                            ],
                          ),
                        ),
                        // Future Feature
                        // Gap(16.w),
                        // Expanded(
                        //   child: TransactionTextField(
                        //     hintText: PaymentCardsStrings.initialBalanceHint,
                        //     controller: _balanceController,
                        //     keyboardType: TextInputType.number,
                        //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        //   ),
                        // ),
                      ],
                    ),
                    Gap(24.h),
                    Text(
                      PaymentCardsStrings.cardType,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Gap(12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceChip(
                          label: const Text(PaymentCardsStrings.mastercard),
                          selected: selectedBrand == CardBrand.mastercard,
                          onSelected: (val) {
                            if (val) {
                              ref.read(selectedBrandProvider.notifier).select(CardBrand.mastercard);
                            }
                          },
                          selectedColor: AppColors.primaryColor,
                          backgroundColor: AppColors.backgroundColor,
                        ),
                        ChoiceChip(
                          label: const Text(PaymentCardsStrings.visa),
                          selected: selectedBrand == CardBrand.visa,
                          onSelected: (val) {
                            if (val) {
                              ref.read(selectedBrandProvider.notifier).select(CardBrand.visa);
                            }
                          },
                          selectedColor: AppColors.primaryColor,
                          backgroundColor: AppColors.backgroundColor,
                        ),
                        ChoiceChip(
                          label: const Text(PaymentCardsStrings.meeza),
                          selected: selectedBrand == CardBrand.meeza,
                          onSelected: (val) {
                            if (val) {
                              ref.read(selectedBrandProvider.notifier).select(CardBrand.meeza);
                            }
                          },
                          selectedColor: AppColors.primaryColor,
                          backgroundColor: AppColors.backgroundColor,
                        ),
                      ],
                    ),
                    Gap(40.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: _submitCard,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          PaymentCardsStrings.addCard,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    Gap(32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
