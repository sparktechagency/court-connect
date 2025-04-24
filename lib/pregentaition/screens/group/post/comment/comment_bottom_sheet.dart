import  'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comment_card_widget.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comtroller/comment_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comtroller/comment_edit_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comtroller/create_comment_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({
    super.key,
    required this.id,
  });

  final String id;
  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final CommentController _controller = Get.put(CommentController());
  final CreateCommentController _createCommentController = Get.put(CreateCommentController());
  final CommentEditController _commentEditController = Get.put(CommentEditController());

  @override
  void initState() {
    _controller.getComment(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: 40.w,
            child: const Divider(
              color: Colors.black,
              thickness: 2,
            ),
          ),
          CustomText(
            text: 'Comments',
            color: Colors.black,
            fontsize: 18.sp,
          ),
          Divider(
            color: AppColors.primaryColor.withOpacity(0.1),
            height: 25.h,
          ),
          Expanded(
            child: Obx(() {
              if (_controller.isLoading.value) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context,index) => _buildSimmer(),
                );
              }
              if (_controller.commentData.isEmpty) {
                return Center(child: CustomText(text: 'No comments yet.'));
              }
              return ListView.builder(
                itemCount: _controller.commentData.length,
                itemBuilder: (context, index) {
                  final commentData = _controller.commentData[index];
                  return CommentCardWidget(
                    commentData: commentData,
                    editAction: () {

                    },
                    deleteAction: () {
                      _commentEditController.deleteComment(widget.id, commentData.sId!);
                    },
                  );
                },
              );
            }),
          ),
          _buildCommentSender()
        ],
      ),
    );
  }

  Widget _buildCommentSender() {
    return SafeArea(
        child: ListTile(
      leading: CustomImageAvatar(
        image: Get.find<HomeController>().userImage.value,
        radius: 18.r,
      ),
      title: CustomTextField(
        validator: (_) => null,
        controller: _createCommentController.commentController,
        contentPaddingVertical: 0,
        hintText: 'Leave your comment..',
        hintextSize: 10.sp,
      ),
      trailing: CustomContainer(
        onTap: () {
          _createCommentController.createComment(widget.id);
          _createCommentController.commentController.clear();
        },
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    ));
  }


  Widget _buildSimmer() {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Circle
            Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),

            // Comment Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Placeholder
                  Container(
                    height: 12.h,
                    width: 100.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),
                  // Comment Line 1
                  Container(
                    height: 10.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 6.h),
                  // Comment Line 2
                  Container(
                    height: 10.h,
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
