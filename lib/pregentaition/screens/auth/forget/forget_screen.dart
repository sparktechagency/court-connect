import 'package:courtconnect/core/widgets/custom_app_bar.dart';
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

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


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
            SizedBox(height: 40.h),
            CustomText(
              text: "Forget Your \n Password?",
              fontsize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Please enter your email to reset \n your password.",
              fontsize: 12.sp,
              color: AppColors.textColor646464,
            ),
            SizedBox(height: 56.h),
            CustomTextField(
              controller: _emailController,
              hintText: "Email",
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 36.h),
            CustomButton(
              label: "Get Verification Code",
              onPressed: _onGetVerificationCode,
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }


  void _onGetVerificationCode(){
    if(_globalKey.currentState!.validate()) return;
    context.pushNamed(AppRoutes.otpScreen);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
