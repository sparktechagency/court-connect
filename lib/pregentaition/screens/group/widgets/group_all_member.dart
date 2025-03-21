import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GroupAllMembersWidget extends StatelessWidget {
  const GroupAllMembersWidget({super.key,  this.images});

  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 130.w,
          height: 60.h,
          child: Stack(
            children: List.generate(
              3,
                  (int index) =>
                  Positioned(left: index * 40, child: const CustomImageAvatar()),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        CustomText(
          text: "147 more",
            color: Colors.black,
            fontsize: 17.sp,
            fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
