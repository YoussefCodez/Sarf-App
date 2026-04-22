
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWithBackGround extends StatelessWidget {
  const IconWithBackGround({super.key, required this.icon, required this.backgroundColor, required this.iconColor, this.iconSize = 32});
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
