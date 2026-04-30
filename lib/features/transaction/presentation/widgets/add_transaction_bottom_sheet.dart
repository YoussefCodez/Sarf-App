import 'package:finance_tracking/config/utils/out_put_print_util.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/transaction_strings.dart';
import 'package:finance_tracking/core/widgets/custom_toast.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/spend_chip_widget.dart';
import 'package:finance_tracking/features/transaction/data/models/transaction_model.dart';
import 'package:finance_tracking/features/transaction/presentation/view/intents/transaction_intents.dart';
import 'package:finance_tracking/features/transaction/presentation/view/providers/transaction_providers.dart';
import 'package:finance_tracking/features/transaction/presentation/view/states/add_transaction_state.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/bottom_sheet_handle.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/transaction_text_field.dart';
import 'package:finance_tracking/features/transaction/presentation/widgets/transaction_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddTransactionBottomSheet extends ConsumerStatefulWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  ConsumerState<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState
    extends ConsumerState<AddTransactionBottomSheet> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'name': TransactionStrings.food, 'icon': Icons.fastfood, 'value': Category.food},
    {'name': TransactionStrings.market, 'icon': Icons.shopping_cart, 'value': Category.market},
    {'name': TransactionStrings.transport, 'icon': Icons.directions_bus, 'value': Category.transport},
    {'name': TransactionStrings.rent, 'icon': Icons.house, 'value': Category.rent},
    {'name': TransactionStrings.medical, 'icon': Icons.medical_services, 'value': Category.medical},
    {'name': TransactionStrings.other, 'icon': Icons.paid_outlined, 'value': Category.other},
  ];

  final List<int> _quickAmounts = [50, 100, 200, 500];

  @override
  void dispose() {
    _priceController.dispose();
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _addQuickAmount(int amount) {
    double current = double.tryParse(_priceController.text) ?? 0;
    _priceController.text = (current + amount).toStringAsFixed(0);
  }

  void _submitTransaction() {
    final typeState = ref.read(transactionTypeProvider);
    final isIncome = typeState.name == 'income';
    final type = ref.read(transactionTypeProvider.notifier).typeString;

    ref
        .read(addTransactionProvider.notifier)
        .handleIntent(
          AddTransactionActionIntent(
            name: isIncome ? '' : _nameController.text,
            priceString: _priceController.text,
            category: isIncome ? 'income' : ref.read(selectedCategoryProvider).name,
            createdAt: DateTime.now(),
            type: type,
            note: _noteController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AddTransactionState>(addTransactionProvider, (previous, next) {
      if (next is AddTransactionSuccess) {
        Navigator.pop(context);
        CustomToast.show(
          context: context,
          message: TransactionStrings.successMessage,
          type: ToastType.success,
        );
      } else if (next is AddTransactionError) {
        printOutPut(next.errorMessage);
        CustomToast.show(
          context: context,
          message: next.errorMessage,
          type: ToastType.error,
        );
      }
    });

    final state = ref.watch(addTransactionProvider);
    final isLoading = state is AddTransactionLoading;
    final typeState = ref.watch(transactionTypeProvider);
    final isIncome = typeState.name == 'income';

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
                padding: REdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TransactionTypeSelector(),
                    Gap(24.h),
                    TransactionTextField(
                      hintText: "0",
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      suffixIcon: Padding(
                        padding: REdgeInsets.all(16),
                        child: Text(
                          TransactionStrings.egp,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.hintTextColor, fontSize: 18.sp),
                        ),
                      ),
                    ),
                    Gap(16.h),
                    Wrap(
                      spacing: 8.w,
                      children: _quickAmounts.map((amount) {
                        return SpendChipWidget(
                          amount: "+$amount",
                          isSelected: false,
                          onPressed: () => _addQuickAmount(amount),
                        );
                      }).toList(),
                    ),
                    if (!isIncome) ...[
                      Gap(24.h),
                      TransactionTextField(
                        hintText: TransactionStrings.productNameHint,
                        controller: _nameController,
                      ),
                    ],
                    Gap(24.h),
                    if (!isIncome) ...[
                      Gap(24.h),
                      Text(
                        TransactionStrings.categoryTitle,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      ),
                      Gap(12.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _categories.map((category) {
                          final categoryName = category['name'] as String;
                          final isSelected =
                              ref.watch(selectedCategoryProvider) ==
                                  category['value'];
                          return SpendChipWidget(
                            amount: categoryName,
                            icon: category['icon'] as IconData,
                            isSelected: isSelected,
                            onPressed: () {
                              ref
                                  .read(selectedCategoryProvider.notifier)
                                  .state = category['value'];
                            },
                          );
                        }).toList(),
                      ),
                    ],
                    Gap(24.h),
                    TransactionTextField(
                      hintText: TransactionStrings.addNoteHint,
                      controller: _noteController,
                    ),
                    Gap(32.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitTransaction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: isLoading
                            ? LoadingAnimationWidget.inkDrop(
                                color: Colors.white,
                                size: 24,
                              )
                            : Text(
                                TransactionStrings.addBtn,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: AppColors.whiteColor),
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
