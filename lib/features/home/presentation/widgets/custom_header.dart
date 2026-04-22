import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text("Hello, Youssef", style: Theme.of(context).textTheme.bodyMedium),
        Gap(4.h),
        Text(
          "Monday, 22 April 2026",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
