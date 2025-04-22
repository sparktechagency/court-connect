import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';

class TwoButtonWidget extends StatelessWidget {
  final List<Map<String, String>> buttons;
  final String selectedValue;
  final Function(String) onTap;
  final double? fontSize;

  const TwoButtonWidget({
    super.key,
    required this.buttons,
    required this.selectedValue,
    required this.onTap, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buttons.map((item) {
        final isSelected = item['value'] == selectedValue;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTap(item['value']!),
            child: CustomContainer(
              horizontalMargin: 6.w,
              radiusAll: 12.r,
              verticalPadding: 8.h,
              color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
              child: CustomText(
                text: item['label']!,
                color: isSelected ? Colors.white : Colors.grey,
                fontsize: fontSize ?? 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
