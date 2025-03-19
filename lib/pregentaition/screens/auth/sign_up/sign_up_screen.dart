import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isChecked = false;


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: Form(
        key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.logo.image(width: 156.w, height: 79.h),
            SizedBox(height: 30.h),
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
              controller: _usernameController,
              hintText: "User Name",
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16.h),
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
            SizedBox(height: 16.h),
            CustomTextField(
              controller: _confirmPasswordController,
              hintText: "Confirm Password",
              isPassword: true,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    _isChecked = !_isChecked;
                    setState(() {});
                  },
                  activeColor: AppColors.primaryColor,
                ),
                CustomText(
                  text: "I agree with ",
                  fontsize: 11.sp,
                  color: AppColors.textColor646464,
                ),
                CustomText(
                  onTap: () {},
                  text: "terms of services ",
                  fontsize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                CustomText(
                  text: "and ",
                  fontsize: 11.sp,
                  color: AppColors.textColor646464,
                ),
                CustomText(
                  onTap: () {},
                  text: "privacy policy.",
                  fontsize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 36.h),
            CustomButton(label: "Sign Up", onPressed: _onSignUp),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Already have an account? ",
                  fontsize: 16.sp,
                  color: AppColors.textColor646464,
                ),
                CustomText(
                  onTap: () {
                    context.pushNamed(AppRoutes.loginScreen);
                  },
                  text: "Sign In",
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

  void _onSignUp() {
    if (!_globalKey.currentState!.validate() && _isChecked) return;
  }


  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
