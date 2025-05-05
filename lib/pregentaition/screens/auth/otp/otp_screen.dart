import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/auth/otp/controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_pin_code_text_field.dart';
import '../../../../core/widgets/custom_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.screenType,});

  final String screenType;


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final OTPController _controller = Get.put(OTPController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.images.logo.image(width: 156.w, height: 79.h),

            SizedBox(height: 40.h),
            CustomText(
              text: "Enter Verification \n Code.",
              fontsize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text:
                  "Please enter the 6 digit verification code sent \n to your e-mail",
              fontsize: 12.sp,
              color: AppColors.textColor646464,
            ),
            SizedBox(height: 56.h),

            ///==============Pin code Field============<>>>>

            Form(
              key: _globalKey,
              child: CustomPinCodeTextField(
                  textEditingController: _controller.otpCtrl),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Obx(() => CustomText(
                    onTap: _controller.isCountingDown.value
                        ? null
                        : () {
                            _controller.resendOTP(context);
                          },
                    top: 10.h,
                    text: _controller.isCountingDown.value
                        ? 'Resend in ${_controller.countdown.value}s'
                        : 'Resend code',
                    color: _controller.isCountingDown.value
                        ? Colors.red
                        : AppColors.primaryColor,
                  )),
            ),

            SizedBox(height: 36.h),
            Visibility(
              visible: !_controller.isLoading.value,
              replacement: const CustomLoader(),
              child: CustomButton(
                label: "Get Verification Code",
                onPressed: _onTapNextScreen,
              ),
            ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }

  void _onTapNextScreen()async {
    if (!_globalKey.currentState!.validate()) return;
    final bool success = await _controller.otpSubmit();
    if(success){
      if(widget.screenType == 'signupScreen'){
        context.goNamed(AppRoutes.loginScreen);

      }else{
        context.pushNamed(AppRoutes.resetPasswordScreen);
      }
    }
  }
}
