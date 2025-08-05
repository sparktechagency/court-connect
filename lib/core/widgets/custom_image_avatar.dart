import 'dart:io';
import 'package:courtconnect/core/widgets/custom_network_image.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomImageAvatar extends StatelessWidget {
  const CustomImageAvatar({
    super.key,
    this.radius = 26,
    this.image,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.fileImage,
  });

  final double radius;
  final String? image;
  final File? fileImage;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top ?? 0,
        right: right ?? 0,
        left: left ?? 0,
        bottom: bottom ?? 0,
      ),
      child: Container(
        padding: EdgeInsets.all(1.r),
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: radius.r,
          backgroundColor: Colors.grey.shade200,
          child: fileImage != null
              ? ClipOval(
            child: Image.file(
              fileImage!,
              width: 2 * radius.r,
              height: 2 * radius.r,
              fit: BoxFit.cover,
            ),
          )
              : CustomNetworkImage(
            boxShape: BoxShape.circle,
            imageUrl: (image != null && image!.isNotEmpty)
                ? "${ApiUrls.imageBaseUrl}/${image!}"
                : "https://templates.joomla-monster.com/joomla30/jm-news-portal/components/com_djclassifieds/assets/images/default_profile.png",
          ),
        ),
      ),
    );
  }
}
