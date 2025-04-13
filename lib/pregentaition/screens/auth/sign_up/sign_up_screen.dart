import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/auth/sign_up/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  final RegisterController _controller = Get.put(RegisterController());

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 44.h),
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
                controller: _controller.usernameController,
                hintText: "User Name",
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _controller.emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _controller.passwordController,
                hintText: "Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (_controller.passwordController.text.length < 8) {
                    return 'Password must be 8+ chars';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _controller.confirmPasswordController,
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != _controller.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: _controller.isChecked.value,
                      onChanged: (value) => _controller.toggleChecked(),
                      activeColor: AppColors.primaryColor,
                    ),
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
              Obx(
                () => _controller.isLoading.value
                    ? const CustomLoader()
                    : CustomButton(label: "Sign Up", onPressed: _onSignUp),
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
                  CustomText(
                    onTap: () {
                      context.pushReplacement(AppRoutes.loginScreen);
                    },
                    text: "Sign In",
                    fontsize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUp() {
    if (!_globalKey.currentState!.validate()) return;
    if(!_controller.isChecked.value){
      return ToastMessageHelper.showToastMessage('Please confirm that you agree to the Terms of Service and Privacy Policy.');
    }
      _controller.registerAccount(context);
  }
}
