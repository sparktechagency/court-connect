import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, this.title, this.subTitle, this.image, this.imageRadius = 26, this.trailing,  this.selectedColor, this.onTap});

  final String? title,subTitle,image;
  final double imageRadius;
  final Widget? trailing;
  final Color? selectedColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selectedColor: selectedColor,
      selected: selectedColor != null ? true : false,
      contentPadding: EdgeInsets.zero,
      leading:  CustomImageAvatar(
        radius: imageRadius.r,
        image: image,
      ),
      title: CustomText(
        textAlign: TextAlign.left,
        text: title ?? '',
        fontWeight: FontWeight.w500,
        fontsize: 16.sp,
      ),
      subtitle: CustomText(
        textAlign: TextAlign.left,
        text: subTitle??'',
        fontWeight: FontWeight.w500,
        fontsize: 10.sp,
        color: Colors.grey,
      ),
      trailing: trailing,
    );
  }
}
