import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, this.title, this.subTitle, this.image, this.imageRadius = 26, this.trailing,  this.selectedColor, this.onTap, this.activeColor, this.statusColor});

  final String? title,subTitle,image;
  final double imageRadius;
  final Widget? trailing;
  final Color? selectedColor;
  final VoidCallback? onTap;
  final Color? activeColor;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      selectedColor: selectedColor,
      selected: selectedColor != null ? true : false,
      contentPadding: EdgeInsets.zero,
      leading:  Stack(
        children: [
          CustomImageAvatar(
            radius: imageRadius.r,
            image: image,
          ),
          if(activeColor != null)
          Positioned(
            right: 5.w,
              child: Icon(Icons.circle,color: activeColor,size: 14.r,)),
        ],
      ),
      title: CustomText(
        textAlign: TextAlign.left,
        text: title ?? '',
        fontWeight: FontWeight.w500,
        fontsize: 16.sp,
      ),
      subtitle: subTitle != null ? Row(
        children: [
          if(statusColor != null)
            Icon(Icons.circle,color: statusColor,size: 10.r,),
          Flexible(
            child: CustomText(
              left: 4,
              textAlign: TextAlign.left,
              text: subTitle??'',
              fontWeight: FontWeight.w500,
              fontsize: 11.sp,
              color: statusColor ?? Colors.grey,
            ),
          ),

        ],
      ) : null,
      trailing: trailing,
    );
  }
}
