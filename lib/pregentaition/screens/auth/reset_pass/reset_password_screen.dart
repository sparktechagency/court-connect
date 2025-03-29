import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/auth/reset_pass/controller/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {


  final ResetPasswordController _controller = Get.put(ResetPasswordController());
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.images.logo.image(width: 156.w, height: 79.h),
        
              SizedBox(height: 40.h),
              CustomText(
                text: "Now Reset Your \n Password.",
                fontsize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "Password  must have 6-8 characters.",
                fontsize: 12.sp,
                color: AppColors.textColor646464,
              ),
              SizedBox(height: 56.h),
        
              CustomTextField(
                controller: _controller.passController,
                hintText: "New Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (_controller.passController.text.length < 8) {
                    return 'Password must be 8+ chars';
                  }
                  return null;
                },
              ),
        
        
        
              SizedBox(height: 16.h),
        
              CustomTextField(
                controller: _controller.confirmPassController,
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != _controller.passController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
        
        
              SizedBox(height: 36.h),
              Obx(()=> _controller.isLoading.value ? const CustomLoader() :CustomButton(
                label: "Reset",
                onPressed: _onResetPassword,
              ),),
              SizedBox(height: 18.h),
        
            ],
          ),
        ),
      ),
    );
  }



  void _onResetPassword(){
    if(!_globalKey.currentState!.validate()) return;
    _controller.resetPassword(context);
  }

}
