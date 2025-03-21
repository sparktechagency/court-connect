import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentCardWidget extends StatelessWidget {
  const CommentCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CustomImageAvatar(
              radius: 18.r,
            ),
            title: CustomText(
              textAlign: TextAlign.start,
              text: 'Austin',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            subtitle: CustomText(
              textAlign: TextAlign.start,
              text: '#User 12345',
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontsize: 10.sp,
            ),
            trailing: CustomText(
              text: '25 min ago',
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontsize: 8.sp,
            ),
          ),
          CustomText(
            textAlign: TextAlign.start,
            text:
                'Hi Adam! Have you had the opportunity to view the media files that were sent over?',
            color: Colors.grey.shade800,
            fontsize: 10.sp,
            maxline: 3,
          ),
        ],
      ),
    );
  }
}
