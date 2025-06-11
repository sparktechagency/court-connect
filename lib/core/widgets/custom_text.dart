import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {super.key,
      this.maxline,
      this.textOverflow,
      this.fontName,
      this.textAlign = TextAlign.center,
      this.left = 0,
      this.right = 0,
      this.top = 0,
      this.bottom = 0,
      this.fontsize,
      this.textHeight,
      this.fontWeight = FontWeight.w400,
      this.color,
      this.text = "",
      this.onTap, this.fontStyle, this.textDecoration});

  final double left;
  final TextOverflow? textOverflow;
  final double right;
  final double top;
  final double bottom;
  final double? fontsize;
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final TextAlign textAlign;
  final int? maxline;
  final String? fontName;
  final double? textHeight;
  final VoidCallback? onTap;
  final FontStyle? fontStyle;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: Text(
          textAlign: textAlign,
          text,
          maxLines: maxline,
          overflow: textOverflow,
          style: TextStyle(
            decoration: textDecoration,
            decorationColor: color ?? AppColors.textColor363636,
            fontStyle: fontStyle,
              fontSize: fontsize ?? 14.h,
              fontFamily: fontName ?? "Montserrat-Regular",
              fontWeight: fontWeight == null ? FontWeight.w400 : fontWeight,
              color: color ?? AppColors.textColor363636),
        ),
      ),
    );
  }
}
