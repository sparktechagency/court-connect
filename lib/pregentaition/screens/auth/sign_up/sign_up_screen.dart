import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60.h),
            Align(
              alignment: Alignment.bottomLeft,
              child: GestureDetector(
                onTap: (){
                  context.pop();
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(5.r),
                      child: const Icon(Icons.arrow_back),
                    )),
              ),
            ),

            Assets.images.logo.image(width: 156.w, height: 79.h),

            SizedBox(height: 40.h),
            CustomText(
              text: "Sign up to your \n account.",
              fontsize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Make sure your account keeps secure",
              fontsize: 12.sp,
              color: AppColors.textColor646464,
            ),
            SizedBox(height: 32.h),

            CustomTextField(
              controller: usernameController,
              hintText: "User Name",
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16.h),
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
            SizedBox(height: 16.h),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              isPassword: true,
            ),
            SizedBox(height: 8.h),

            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    isChecked = !isChecked;
                    setState(() {});
                  },
                  activeColor: AppColors.primaryColor,
                ),
                CustomText(
                  text: "I agree with ",
                  fontsize: 11.sp,
                  color: AppColors.textColor646464,
                ),
                GestureDetector(
                  onTap: () {
                    // Open Terms of Service
                  },
                  child: CustomText(
                    text: "terms of services ",
                    fontsize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                CustomText(
                  text: "and ",
                  fontsize: 11.sp,
                  color: AppColors.textColor646464,
                ),
                GestureDetector(
                  onTap: () {
                    // Open Privacy Policy
                  },
                  child: CustomText(
                    text: "privacy policy.",
                    fontsize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: 36.h),
            CustomButton(
              title: "Sign Up",
              onpress: () {
                // Implement sign-up functionality
              },
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Already have an account? ",
                  fontsize: 16.sp,
                  color: AppColors.textColor646464,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to Sign In screenr
                  },
                  child: CustomText(
                    text: "Sign In",
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
