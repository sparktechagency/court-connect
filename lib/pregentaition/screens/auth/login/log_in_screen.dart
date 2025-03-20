import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60.h),
            Assets.images.logo.image(width: 156.w, height: 79.h),
            SizedBox(height: 82.h),
            CustomText(
                text: "Sign in to your account.",
                fontsize: 24.sp,
                fontWeight: FontWeight.bold),
            SizedBox(height: 8.h),
            CustomText(
              text: "Make sure that you already have an \n account.",
              fontsize: 12.sp,
              color: AppColors.textColor646464,
            ),
            SizedBox(height: 53.h),
            CustomTextField(
              controller: _emailController,
              hintText: "Email",
              keyboardType: TextInputType.emailAddress,
              isEmail: true,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: _passwordController,
              hintText: "Password",
              isPassword: true,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: CustomText(
                onTap: () {
                  context.pushNamed(AppRoutes.forgetScreen);
                },
                text: "Forgot Password",
                fontsize: 14.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 111.h),
            CustomButton(
              label: "Sign In",
              onPressed: _onSingUp,
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
                CustomText(
                  onTap: () {
                    context.pushNamed(AppRoutes.signUpScreen);
                  },
                  text: "Sign Up",
                  fontsize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSingUp() {
    if (_globalKey.currentState!.validate()) return;
    context.goNamed(AppRoutes.customBottomNavBar);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
