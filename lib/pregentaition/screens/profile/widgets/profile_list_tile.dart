import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile(
      {super.key,
      this.color,
      this.textColor,
      this.noIcon,
      required this.title,
      required this.onTap, required this.icon});

  final Color? color;
  final Color? textColor;
  final bool? noIcon;
  final String title;
  final VoidCallback onTap;
   final Widget icon;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      verticalMargin: 7.h,
      horizontalPadding: 16.w ,
      verticalPadding: 14.h,
      color: color ?? const Color(0xFFF6F6F6),
      radiusAll: 12.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: 12.w),
          Expanded(
            child: CustomText(
              text: title,
              textAlign: TextAlign.start,
              color: textColor ?? AppColors.textColor363636,
              fontsize: 14.sp,
            ),
          ),
          if (noIcon != true)
            Icon(
              Icons.arrow_forward_ios,
              size: 16.h,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}
