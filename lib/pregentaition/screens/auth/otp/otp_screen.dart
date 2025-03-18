import 'dart:async';

import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class OtpScreen extends StatelessWidget {

  final TextEditingController otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),
              Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: (){

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
                text: "Enter Verification \n Code.",
                fontsize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "Please enter the 6 digit verification code sent \n to your e-mail",
                fontsize: 12.sp,
                color: AppColors.textColor646464,
              ),
              SizedBox(height: 56.h),
          
              ///==============Pin code Field============<>>>>
          
              CustomPinCodeTextField(textEditingController: otpCtrl),
          
          
          
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() => GestureDetector(
                  onTap: isCountingDown.value
                      ? null
                      : () {
                    startCountdown();
                  },
                  child: CustomText(
                    text: isCountingDown.value
                        ? 'Resend in ${countdown.value}s'
                        : 'Resend code',
                    color: isCountingDown.value
                        ? Colors.red
                        : AppColors.primaryColor,

                  ),
                )),
              ),
          
          
              SizedBox(height: 36.h),
              CustomButton(
                label: "Get Verification Code",
                onPressed: () {
                  context.goNamed(AppRoutes.resetPasswordScreen);
                },
              ),
              SizedBox(height: 18.h),
          
            ],
          ),
        ),
      ),
    );
  }

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




class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({super.key, this.textEditingController});
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: textEditingController,
      length: 6,
      defaultPinTheme: PinTheme(
        width: 120.w,
        height: 60.h,
        textStyle: const TextStyle(color: AppColors.textColor363636, fontSize: 20),
        decoration: BoxDecoration(
          color: const Color(0xffD3D3D3),
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      focusedPinTheme: PinTheme(
        width: 120.w,
        height: 60.h,
        textStyle: const TextStyle(color: AppColors.textColor363636, fontSize: 20),
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryColor),
        ),
      ),
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 2,
            height: 20,
            color: AppColors.textColor646464,
          ),
        ],
      ),
      keyboardType: TextInputType.number,
      obscureText: false,
      autofocus: false,
      onChanged: (value) {},
    );
  }
}
