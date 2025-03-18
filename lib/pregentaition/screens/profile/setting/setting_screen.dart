import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jotter/global_widgets/custom_text.dart';
import 'package:jotter/global_widgets/dialog.dart';
import 'package:jotter/routes/app_routes.dart';
import 'package:jotter/utils/app_colors.dart';
import 'package:jotter/utils/app_icons.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextOne(
          text: 'Setting',
          fontSize: 18.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          children: [
            _buildOption(
                iconPath: AppIcons.password,
                title: 'Change Password',
                onTap: () {
                 Get.toNamed(AppRoutes.changePassword);
                }),
            _buildOption(
                iconPath: AppIcons.terms,
                title: 'Terms & Conditions',
                onTap: () {
                Get.toNamed(AppRoutes.termsScreen);
                }),
            _buildOption(
                iconPath: AppIcons.privacy,
                title: 'Privacy Policy',
                onTap: () {
                Get.toNamed(AppRoutes.privacyPolicyScreen);
                }),
            _buildOption(
              iconPath: AppIcons.about,
              title: "About Us",
              onTap: () {
               Get.toNamed(AppRoutes.aboutScreen);
              },
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: _buildOption(
                  iconPath: AppIcons.delete,
                  title: 'Delete Account',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: "Do you want to delete your account ?",
                        confirmButtonText: 'Delete',
                        confirmButtonColor: Colors.red,
                        onCancel: () {
                          // Handle Cancel Button Action
                          Get.back();
                        },
                        onConfirm: () {
                          // Handle Log Out Action
                          Get.offAllNamed(AppRoutes.signInScreen);
                        },
                      ),
                    );
                  },
                  noIcon: true,
                  color: Colors.red.withOpacity(0.2),
                  textColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color? color,
    Color? textColor,
    bool? noIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: color ?? Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(iconPath, height: 20.h, width: 20.w),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextOne(
                  text: title,
                  textAlign: TextAlign.start,
                  color: textColor ?? AppColors.textColor,
                  fontSize: 14.sp,
                ),
              ),
              if (noIcon != true)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.h,
                  color: Colors.grey,
                ),
            ],
          ),
        ),
      ),
    );
  }
}