import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_network_image.dart';
import 'package:courtconnect/core/widgets/custom_popup.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/group/post/models/post_data.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCardWidget extends StatefulWidget {
  const PostCardWidget(
      {super.key,
      this.isMyPost = false,
      this.media,
      this.profileName,
      this.description,
      this.time,
      this.comments,
      this.profileImage,
      this.onCommentsView,
      this.menuItems,
      this.onSelected});

  final bool isMyPost;
  final List<Media>? media;
  final String? profileImage;
  final String? profileName;
  final String? description;
  final String? time;
  final String? comments;
  final VoidCallback? onCommentsView;
  final List<String>? menuItems;
  final Function(String)? onSelected;

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
              blurRadius: 2)
        ],
        child: Column(
          children: [
            SizedBox(height: 6.h),
            CustomListTile(
              imageRadius: 22.r,
              image: widget.profileImage,
              title: widget.profileName,
              subTitle: widget.time,
              trailing: widget.isMyPost
                  ? CustomPopupMenu(
                      icon: Icons.edit_note,
                      iconColor: Colors.grey.shade600,
                      items: widget.menuItems ?? [],
                      onSelected: widget.onSelected,
                    )
                  : null,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                maxline: 20,
                bottom: 10.h,
                fontsize: 10.sp,
                textAlign: TextAlign.start,
                text: widget.description ?? '',
              ),
            ),
            if (widget.media != null && widget.media!.isNotEmpty) ...[
              SizedBox(height: 6.h),
              SizedBox(
                width: double.infinity,
                height: 300.h,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: widget.media?.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CustomNetworkImage(
                            imageUrl:
                                '${ApiUrls.imageBaseUrl}${widget.media?[index].publicFileURL ?? ''}'),
                      ),
                    ),
                    Positioned(
                        right: 10.0.w,
                        top: 6.0.h,
                        child: CustomContainer(
                            horizontalPadding: 8.w,
                            verticalPadding: 2.h,
                            radiusAll: 10.r,
                            color: Colors.black.withOpacity(0.5),
                            child: CustomText(
                              text:
                                  '${_currentPage + 1}/${widget.media!.length}',
                              color: Colors.white,
                              fontsize: 10.sp,
                              fontWeight: FontWeight.w600,
                            )))
                  ],
                ),
              ),
              if ((widget.media?.length ?? 0) > 1)
                Positioned(
                  left: 0.0.w,
                  right: 0.0.w,
                  bottom: 0.0.h,
                  child: DotsIndicator(
                    position: _currentPage.toDouble(),
                    dotsCount: widget.media!.length,
                    decorator: DotsDecorator(
                      size: Size.square(5.0.r),
                      spacing: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 6.h), // Space between dots
                      activeColor: AppColors.primaryColor,
                    ),
                  ),
                )
            ],
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: GestureDetector(
                onTap: widget.onCommentsView,
                child: Row(
                  spacing: 4.w,
                  children: [
                    Assets.icons.comment.svg(),
                    Flexible(
                      child: CustomText(
                        fontsize: 10.sp,
                        textAlign: TextAlign.start,
                        text: 'View ${widget.comments} comments',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
