import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ForgetScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();

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
              controller: emailController,
              hintText: "Email",
              keyboardType: TextInputType.text,
            ),

            SizedBox(height: 36.h),
            CustomButton(
              title: "Get Verification Code",
              onpress: () {
                context.goNamed(AppRoutes.otpScreen);
              },
            ),
            SizedBox(height: 18.h),

          ],
        ),
      ),
    );
  }
}
