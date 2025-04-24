import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comtroller/comment_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comtroller/comment_edit_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comtroller/create_comment_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/controller/create_post_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/controller/post_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/controller/post_edit_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comment_bottom_sheet.dart';
import 'package:courtconnect/pregentaition/screens/group/post/models/post_data.dart';
import 'package:courtconnect/pregentaition/screens/group/post/widgets/post_card_widget.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.id});

  final String id;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final PostController _controller = Get.put(PostController());
  final EditPostController _editPostController = Get.put(EditPostController());
  final CommentController _commentController = Get.put(CommentController());
  final CreateCommentController _createCommentController = Get.put(CreateCommentController());

  final CommentEditController _commentEditController = Get.put(CommentEditController());



  final _types = [
    {'label': 'All Post', 'value': 'all'},
    {'label': 'My Post', 'value': 'my'},
  ];


  @override
  void initState() {
    super.initState();
    _controller.communityId.value = widget.id;
    _controller.getPost();
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Post',
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(AppRoutes.createPostScreen,extra: {
                  'id' : widget.id,
                });
              },
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        spacing: 16.h,
        children: [


          Obx(() {
            return TwoButtonWidget(
              fontSize: 18.sp,
              buttons: _types,
              selectedValue: _controller.type.value,
              onTap: _controller.onChangeType,
            );
          }),


          Expanded(
            child: Obx(
                  () {

                return RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    await _controller.getPost();
                  },
                  child: _controller.isLoading.value
                      ? ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return _buildShimmer(height: 300.h);
                    },
                  )
                      : _controller.postDataList.isEmpty
                      ? Center(child: CustomText(text: 'No posts available'))
                      : ListView.builder(
                    itemCount: _controller.postDataList.length,
                    itemBuilder: (context, index) {
                      final postData = _controller.postDataList[index];
                      return PostCardWidget(
                        profileImage: postData.user?.image ?? '',
                        profileName: postData.user?.name ?? '',
                        description: postData.description ?? '',
                        media: postData.media ?? [],
                        time: TimeFormatHelper.getTimeAgo(
                          DateTime.parse(postData.createdAt ?? ''),
                        ),
                        comments: postData.totalComments.toString(),
                        onCommentsView: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return  CommentBottomSheet(id: postData.sId!,);
                            },
                          );
                        },
                        isMyPost: _controller.type.value == 'my',

                        menuItems: _controller.type.value == 'all'
                            ? []
                            : ['Edit', 'Delete',],
                        onSelected: (val) {
                          if (val == 'Delete') {
                            showDeleteORSuccessDialog(context, onTap: () {
                              context.pop();
                              _editPostController.deletePost(context,postData.sId!,widget.id);
                            });
                          } else if (val == 'Edit') {
                            context.pushNamed(AppRoutes.editPostScreen,extra: {
                              'media' : postData.media ?? [],
                              'des' : postData.description ?? '',
                            });
                          }
                        },

                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer({required double height}) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: const Duration(milliseconds: 800),
        child: CustomContainer(
          radiusAll: 8.r,
          height: height,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }

}
