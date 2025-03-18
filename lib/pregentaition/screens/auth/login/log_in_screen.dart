import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 110.h),

            Assets.images.logo.image(width: 156.w, height: 79.h),


            SizedBox(height: 82.h),
            CustomText(
              text: "Sign in to your account.",
              fontsize: 24.sp,
              fontWeight: FontWeight.bold
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Make sure that you already have an \n account.",
              fontsize: 12.sp,
              color: AppColors.textColor646464,
            ),
            SizedBox(height: 53.h),
            CustomTextField(
              controller: emailController,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              isEmail: true,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: passwordController,
              hintText: "Password",
              isPassword: true,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  context.goNamed(AppRoutes.forgetScreen);
                },
                child: CustomText(
                  text: "Forgot Password",
                  fontsize: 14.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 111.h),
            CustomButton(
              title: "Sign In",
              onpress: () {
                context.goNamed(AppRoutes.profileScreen);
              },
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Don't have an account? ",
                  fontsize: 16.sp,
                  color: AppColors.textColor646464,
                ),
                GestureDetector(
                  onTap: () {
                    context.goNamed(AppRoutes.signUpScreen);
                  },
                  child: CustomText(
                    text: "Sign Up",
                    fontsize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
