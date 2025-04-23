import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_network_image.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget(
      {super.key,
      this.isMyPost = false,
      this.image,
      this.profileName,
      this.description,
      this.time,
      this.comments,
      this.profileImage, this.onCommentsView});

  final bool isMyPost;
  final String? image;
  final String? profileImage;
  final String? profileName;
  final String? description;
  final String? time;
  final String? comments;
  final VoidCallback? onCommentsView;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.white,
      horizontalPadding: 10.w,
      radiusAll: 8.r,
      verticalMargin: 6.h,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 2
        )
      ],
      child: Column(
        children: [
          SizedBox(height: 6.h),
          CustomListTile(
            imageRadius: 20.r,
            image: profileImage,
            title: profileName,
            trailing: isMyPost ? _buildDropdownMenu(context) : null,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              maxline: 20,
              top: 10.h,
              bottom: 10.h,
              fontsize: 10.sp,
              textAlign: TextAlign.start,
              text: description ?? '',
            ),
          ),
          if (image != null && image != '') ...[
            SizedBox(height: 6.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CustomNetworkImage(imageUrl: image ?? ''),
            ),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCommentsView,
                    child: Row(
                      spacing: 4.w,
                      children: [
                        Assets.icons.comment.svg(),
                        CustomText(
                          fontsize: 10.sp,
                          textAlign: TextAlign.start,
                          text: 'View $comments comments',
                        ),
                      ],
                    ),
                  ),
                ),
                CustomText(
                  fontsize: 10.sp,
                  textAlign: TextAlign.start,
                  text: time ?? '',
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _buildDropdownMenu(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (value) {
        if (value == 'Edit') {
          context.pushNamed(AppRoutes.createPostScreen);
        } else if (value == 'Delete') {}
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Edit',
          child: Row(
            children: [
              const Icon(Icons.edit, color: Colors.black),
              CustomText(text: 'Edit Post'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'Delete',
          child: Row(
            children: [
              const Icon(Icons.delete_outline, color: Colors.red),
              CustomText(text: 'Delete', color: Colors.red),
            ],
          ),
        ),
      ],
      child: const Icon(Icons.more_horiz_outlined, color: Colors.black54),
    );
  }
}
