import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupAllMembersWidget extends StatelessWidget {
  const GroupAllMembersWidget({super.key,this.totalMember, required this.members, this.onTap});

  final List<Members> members;
  final int? totalMember;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    int displayCount = members.length > 3 ? 3 : members.length;
    double imageSize = 50.w;
    double spacing = 8.w;
    double totalWidth = imageSize + (displayCount - 1) * (imageSize - spacing);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: totalWidth.w,
            height: 60.h,
            child: Stack(
              children: List.generate(
                displayCount,
                (int index) => Positioned(
                    left: index * (imageSize - spacing),
                    child: CustomImageAvatar(
                      image: members[index].image ?? '',
                    )),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          CustomText(
            text: "$totalMember more",
            color: Colors.black,
            fontsize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
