import 'package:finance_tracking/core/theme/app_colors.dart';
import 'package:finance_tracking/core/app_strings/settings_strings.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/providers/get_profile_provider.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(getProfileProvider);

    String name = SettingsStrings.loading;
    String userId = SettingsStrings.noUserId;
    if (profileState is GetProfileSuccess) {
      name = profileState.userProfileEntity.name;
      userId = profileState.userProfileEntity.id;
    } else if (profileState is GetProfileError) {
      name = SettingsStrings.user;
      userId = SettingsStrings.noUserId;
    }

    return Row(
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondCardColor,
            border: Border.all(color: AppColors.primaryColor, width: 2),
          ),
          child: profileState is GetProfileLoading 
              ? Padding(
                  padding: REdgeInsets.all(20),
                  child: LoadingAnimationWidget.inkDrop(color: AppColors.primaryColor, size: 20.sp)
                )
              : Icon(Icons.person, color: AppColors.primaryColor, size: 35.sp),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Gap(4.h),
              Text(
                userId,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.hintTextColor,
                  fontSize: 12.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
