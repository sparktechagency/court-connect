import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../utils/app_colors.dart';

class CustomPinCodeTextField extends StatefulWidget {
  const CustomPinCodeTextField(
      {super.key, this.textEditingController, this.validator});

  final TextEditingController? textEditingController;
  final FormFieldValidator? validator;

  @override
  State<CustomPinCodeTextField> createState() => _CustomPinCodeTextFieldState();
}

class _CustomPinCodeTextFieldState extends State<CustomPinCodeTextField> {
  @override
  Widget build(BuildContext context) {
    return Pinput(
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Please enter OTP";
            } else if (value.length != 6 ||
                !RegExp(r'^\d{6}$').hasMatch(value)) {
              return "Enter a valid 6-digit OTP";
            }
            return null;
          },
      controller: widget.textEditingController,
      length: 6,
      defaultPinTheme: PinTheme(
        width: 120.w,
        height: 60.h,
        textStyle:
            const TextStyle(color: AppColors.textColor363636, fontSize: 20),
        decoration: BoxDecoration(
          color: const Color(0xffD3D3D3),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 120.w,
        height: 60.h,
        textStyle:
            const TextStyle(color: AppColors.textColor363636, fontSize: 20),
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
