import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/group/post/widgets/comment_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({
    super.key,
  });

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {

  final TextEditingController _commentController = TextEditingController();

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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const CommentCardWidget();
              },
            ),
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
          radius: 18.r,
        ),
        title: CustomTextField(controller: _commentController,contentPaddingVertical: 0,
          hintText: 'Leave your comment..',
          hintextSize: 10.sp,
        ),
        trailing: const CustomContainer(
          color: AppColors.primaryColor,
              shape: BoxShape.circle,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.send,color: Colors.white,),
          ),
        ),)
    );
  }


  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }
}
