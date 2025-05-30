import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupAllMembersWidget extends StatelessWidget {
  const GroupAllMembersWidget({super.key,this.totalMember, required this.members, this.onTap});

  final List<Members> members;
  final int? totalMember;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    List<String> fullImageUrls = members
        .map((member) => member.image)
        .where((img) => img != null && img.isNotEmpty)
        .map((img) => '${ApiUrls.imageBaseUrl}$img')
        .toList();
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          FlutterImageStack(
            itemBorderColor: AppColors.primaryColor,
            imageList: fullImageUrls,
            //showTotalCount: true,
            totalCount: 0,
            itemRadius: 52.r,
            itemCount: 3,
            itemBorderWidth: 2,
          ),

          SizedBox(width: 6.w),
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
