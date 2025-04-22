import 'package:cached_network_image/cached_network_image.dart';
import 'package:courtconnect/core/widgets/custom_network_image.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupCardWidget extends StatelessWidget {
  const GroupCardWidget(
      {super.key,
      this.profileImage,
      this.coverImage,
      this.title,
      this.subTitle,
      this.detailAction});

  final String? profileImage, coverImage, title, subTitle;
  final VoidCallback? detailAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(6.r),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(8.r)),
                  child: SizedBox(
                      height: 140.h,
                      width: double.infinity,
                      child: CustomNetworkImage(
                        imageUrl: coverImage ?? '',
                      )),
                ),
                SizedBox(height: 24.h),
                CustomText(
                  text: title ?? '',
                  fontsize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: subTitle ?? '',
                  fontsize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
          if (detailAction != null)
            Positioned(
                right: 10.w,
                top: 10.h,
                child: GestureDetector(
                    onTap: detailAction,
                    child: Assets.icons.detailsIcons.svg())),
        ],
      ),
    );
  }
}
