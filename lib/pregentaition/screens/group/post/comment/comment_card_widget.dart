import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/models/commant_data.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentCardWidget extends StatelessWidget {
  const CommentCardWidget({super.key, required this.commentData,  this.editAction, this.deleteAction});


  final CommentData commentData;
  final VoidCallback? editAction;
  final VoidCallback? deleteAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onLongPressStart: (details) {
              _showPopupMenu(context, details.globalPosition);
            },

            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CustomImageAvatar(
                radius: 18.r,
              ),
              title: CustomText(
                textAlign: TextAlign.start,
                text: commentData.user?.name ?? '',
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              subtitle: CustomText(
                textAlign: TextAlign.start,
                text: commentData.comment ?? '',
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontsize: 10.sp,
              ),
              trailing: CustomText(
                text: TimeFormatHelper.getTimeAgo(DateTime.parse(commentData.createdAt ?? '')),
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontsize: 8.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Offset offset) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;


   if (commentData.user?.sId == Get.find<HomeController>().userId.value) {
     showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromRect(
        offset & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
         PopupMenuItem<int>(
          value: 0,
          child: CustomText(text: 'Edit'),
        ),
         PopupMenuItem<int>(
          value: 1,
          child: CustomText(text: 'Delete'),
        ),
      ],
    ).then((selectedValue) {
      if (selectedValue == 0) {
        editAction!();
      } else if (selectedValue == 1) {
        deleteAction!();

      }
    });
   }
  }

}
