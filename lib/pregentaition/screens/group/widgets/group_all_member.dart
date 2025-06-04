import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupAllMembersWidget extends StatelessWidget {
  const GroupAllMembersWidget({
    super.key,
    this.totalMember,
    required this.members,
    this.onTap,
  });

  final List<Members> members;
  final int? totalMember;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    int missingImageCount = 0;
    List<String> fullImageUrls = members.map((member) {
      final image = member.image;
      if (image == null || image.isEmpty) {
        if (missingImageCount < 3) {
          missingImageCount++;
          return 'https://templates.joomla-monster.com/joomla30/jm-news-portal/components/com_djclassifieds/assets/images/default_profile.png'; // your asset image
        } else {
          return '';
        }
      } else {
        return '${ApiUrls.imageBaseUrl}$image';
      }
    }).where((url) => url.isNotEmpty).toList();

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          FlutterImageStack(
            itemBorderColor: AppColors.primaryColor,
            imageList: fullImageUrls,
            itemRadius: 52.r,
            itemCount: 3, // Number of avatars to show in stack
            itemBorderWidth: 2,
            totalCount: 0,
            showTotalCount: false,
            backgroundColor: Colors.grey.shade200,
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
