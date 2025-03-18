import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../global/custom_assets/assets.gen.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final Color? color;
  final Color? titlecolor;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool loading;
  final bool loaderIgnore;

  CustomButton({
    super.key,
    required this.title,
    required this.onpress,
    this.color,
    this.height,
    this.width,
    this.fontSize,
    this.titlecolor,
    this.loading=false,
    this.loaderIgnore = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading?(){} : onpress,
      child: Container(
        width:width?? 345.w,
        height: height ?? 52.h,
        padding:  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primaryColor),
          color: color ?? AppColors.primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

           loaderIgnore ? SizedBox() : SizedBox(width: 30.w),


            Center(
              child: CustomText(
                text: title,
                fontsize: fontSize ?? 16.h,
                color: titlecolor ?? Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),


            loaderIgnore ? SizedBox() :  SizedBox(width: 20.w),


            loaderIgnore ? SizedBox() :  loading  ?
                SizedBox(
                    height: 25.h,
                    width: 25.w,
                    child: Assets.lottie.buttonLoading.lottie(fit: BoxFit.cover)
                ) :  SizedBox(width: 25.w)
          ],
        ),
      ),
    );
  }
}