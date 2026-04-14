import 'package:finance_tracking/core/app_strings/on_boarding_strings.dart';
import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/intents/why_tracking_intent.dart';
import 'package:finance_tracking/features/on_boarding/presentation/view_models/providers/why_tracking_provider.dart';
import 'package:finance_tracking/features/on_boarding/presentation/widgets/select_goal_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class AddGoal extends ConsumerStatefulWidget {
  const AddGoal({super.key});

  @override
  ConsumerState<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends ConsumerState<AddGoal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _imagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectGoalPhoto(
                    imagePath: _imagePath,
                    onTap: () async {
                      final image = await _imagePicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null) {
                        setState(() {
                          _imagePath = image.path;
                        });
                      }
                    },
                  )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.1, end: 0, duration: 500.ms),
              Gap(40.h),
              Text(
                    OnBoardingStrings.goalName,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 200.ms)
                  .slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(10.h),
              TextFormField(
                    controller: _nameController,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: 20.h,
                    validator: (value) {
                      if (value == null || value.trim().length < 5) {
                        return OnBoardingStrings.goalNameError;
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.labelSmall,
                    decoration: InputDecoration(
                      hintText: OnBoardingStrings.goalNameHint,
                      hintStyle: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(fontSize: 16.sp),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 400.ms)
                  .slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(30.h),
              Text(
                    OnBoardingStrings.targetAmount,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 600.ms)
                  .slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(10.h),
              TextFormField(
                    controller: _amountController,
                    cursorColor: AppColors.primaryColor,
                    cursorHeight: 30.h,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return OnBoardingStrings.targetAmountHint;
                      }
                      final amount = double.tryParse(value);
                      if (amount == null || amount < 50) {
                        return OnBoardingStrings.minAmountError;
                      }
                      return null;
                    },
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 32.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: OnBoardingStrings.targetAmountHint,
                      hintStyle: Theme.of(context).textTheme.bodyLarge!
                          .copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                          ),
                      suffixIcon: Container(
                        padding: REdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              OnBoardingStrings.egp,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      contentPadding: REdgeInsets.symmetric(vertical: 20.h),
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 800.ms)
                  .slideX(begin: 0.1, end: 0, duration: 500.ms),
              Gap(20.h),
              Row(
                children: [
                  Expanded(
                    child:
                        ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: AppColors.primaryColor,
                                side: BorderSide(color: AppColors.primaryColor),
                              ),
                              onPressed: () {
                                ref
                                    .read(whyTrackingNotifierProvider.notifier)
                                    .handleIntent(
                                      const SetIsSavingForGoalIntent(isSavingForGoal: false),
                                    );
                              },
                              child: Text(
                                OnBoardingStrings.back,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 1000.ms)
                            .slideX(begin: 0.1, end: 0, duration: 500.ms),
                  ),
                  Gap(16.w),
                  Expanded(
                    child:
                        ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(
                                        whyTrackingNotifierProvider.notifier,
                                      )
                                      .handleIntent(
                                        AddGoalIntent(
                                          name: _nameController.text,
                                          amount: _amountController.text,
                                          imagePath: _imagePath ?? "",
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                OnBoardingStrings.continueButton,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 1000.ms)
                            .slideX(begin: 0.1, end: 0, duration: 500.ms),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
