import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TwoButtonWidget extends StatelessWidget {
  final List<String> buttons;
  final int selectedIndex;
  final Function(int) onTap;

  const TwoButtonWidget({
    super.key,
    required this.buttons,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20.w,
      children: List.generate(buttons.length, (index) {
        return Expanded(
          child: CustomContainer(
            verticalPadding: 8.h,
            radiusAll: 12.r,
            color: selectedIndex == index
                ? AppColors.primaryColor
                : Colors.grey.shade300,
            onTap: () => onTap(index),
            child: CustomText(
              text: buttons[index],
              color: selectedIndex == index ? Colors.white : Colors.grey,
              fontsize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }),
    );
  }
}
