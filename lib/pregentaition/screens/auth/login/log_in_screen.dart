import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/auth/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  final LoginController _controller = Get.put(LoginController());
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
              Obx(() => _controller.isLoading.value ? const CustomLoader() : CustomButton(
                label: "Sign In",
                onPressed: (){
                  context.pushReplacementNamed(AppRoutes.customBottomNavBar);

                },
              )),
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
                      context.pushReplacement(AppRoutes.signUpScreen);
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
      ),
    );
  }

  void _onLogin() {
    if (!_globalKey.currentState!.validate()) return;
    _controller.login(context);
  }

}
