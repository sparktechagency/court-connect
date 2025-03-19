import 'package:cached_network_image/cached_network_image.dart';
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
  });

  final double radius;
  final String? image;
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
          backgroundColor: Colors.grey.shade300,
          backgroundImage: image != null && image!.isNotEmpty
              ? CachedNetworkImageProvider(image!)
              : null,
          child: (image == null || image!.isEmpty)
              ? Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 44.r,
                )
              : null,
        ),
      ),
    );
  }
}
