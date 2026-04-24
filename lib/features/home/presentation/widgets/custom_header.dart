import 'package:finance_tracking/features/get_profile/presentation/view/providers/get_profile_provider.dart';
import 'package:finance_tracking/features/get_profile/presentation/view/states/get_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final formatted = DateFormat('EEEE, d MMMM yyyy').format(now);
    return Column(
      crossAxisAlignment: .start,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(getProfileProvider);
            switch (state) {
              case GetProfileLoading():
                return Skeletonizer(
                  enabled: true,
                  child: Text("Hello Youssef"),
                );
              case GetProfileError():
                return Text("Hello");
              case GetProfileSuccess(userProfileEntity: final profile):
                return Text(
                  "Hello, ${profile.name}",
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              case GetProfileInitial():
                return const SizedBox.shrink();
            }
          },
        ),
        Gap(4.h),
        Text(
          formatted,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
