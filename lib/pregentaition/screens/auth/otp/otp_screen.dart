import 'dart:async';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/auth/otp/controller/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_pin_code_text_field.dart';
import '../../../../core/widgets/custom_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

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
              child: CustomPinCodeTextField(textEditingController: _controller.otpCtrl),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Obx(() => CustomText(
                    onTap: isCountingDown.value
                        ? null
                        : () {
                            startCountdown();
                          },
                    top: 10.h,
                    text: isCountingDown.value
                        ? 'Resend in ${countdown.value}s'
                        : 'Resend code',
                    color: isCountingDown.value
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

  void _onTapNextScreen() {
    if (!_globalKey.currentState!.validate()) return;
    _controller.otpSubmit(context);
  }

  /// <==================time count function hare====================>
  final RxInt countdown = 10.obs;

  final RxBool isCountingDown = false.obs;

  void startCountdown() {
    isCountingDown.value = true;
    countdown.value = 10;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
        isCountingDown.value = false;
      }
    });
  }
}
