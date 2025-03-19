import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.icon,
    this.child,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.fontWeight,
    this.fontSize,
    this.fontFamily,
    this.paddingHorizontal,
    this.paddingVertical,
    required this.onPressed, this.radius,
  });

  final IconData? icon;
  final Widget? child;
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? radius;
  final String? fontFamily;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 100.r)),
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 8.w,
          vertical: paddingVertical ?? 0,
        ),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        foregroundColor: foregroundColor ?? Colors.white,
        fixedSize: Size(width ?? double.maxFinite, height ?? 40.h),
        textStyle: TextStyle(
          fontFamily: fontFamily ?? 'Montserrat',
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: fontSize ?? 18.sp,
          color: Colors.white
        ),
      ),
      onPressed: onPressed,
      label:
          child != null
              ? child!
              : child == null && label != null
              ? Text(label!)
              : const SizedBox.shrink(),
      icon: icon != null ? Icon(icon, color: Colors.white) : null,
    );
  }
}
