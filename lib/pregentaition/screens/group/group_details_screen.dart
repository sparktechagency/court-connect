import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/pregentaition/screens/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/widgets/group_card_widget.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:shimmer/shimmer.dart';
import 'controller/group_controller.dart';
import 'widgets/group_all_member.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final GroupController _controller = Get.put(GroupController());

  String getFullImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '${ApiUrls.imageBaseUrl}$path';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getGroupDetails(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = _controller.groupDetailsData.value;
      _controller.communityId.value = widget.id;

      if (_controller.isLoading.value) {
        return _buildShimmer();
      }

      return CustomScaffold(
        appBar: const CustomAppBar(title: 'Group Details'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Cover Image + Title
            GroupCardWidget(
              coverImage:
                  '${ApiUrls.imageBaseUrl}${data.communityImage ?? ''}',
              title: data.communityName ?? '',
              subTitle: '${data.totalMembers ?? ''} Members',
            ),

            /// Description
            SizedBox(height: 16.h),
            CustomText(
                text: 'Description', bottom: 6.h, color: Colors.grey),
            CustomContainer(
              width: double.infinity,
              verticalPadding: 8.w,
              horizontalPadding: 16.w,
              radiusAll: 8.r,
              color: Colors.grey.shade300,
              child: CustomText(
                maxline: 7,
                fontsize: 12.sp,
                textAlign: TextAlign.left,
                text: data.communityDescription ?? '',
              ),
            ),

            /// Creator
            CustomText(
              text: 'Group Creator',
              top: 20.h,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              bottom: 10.h,
            ),
            CustomListTile(
              onTap: (){
                if(Get.find<HomeController>().userId.value == data.creator!.sId!){
                  context.pushNamed(AppRoutes.customBottomNavBar);
                  Get.find<CustomBottomNavBarController>().onChange(3);
                }else{
                  context.pushNamed(AppRoutes.otherProfileScreen,extra: {
                    'id' : data.creator!.sId!,
                  });
                }
              },
              image: data.creator?.image?.publicFileURL ?? '',
              title: data.creator?.name ?? '',
            ),

            /// Members
            if ((data.totalMembers ?? 0) > 0) ...[
              CustomText(
                  text: 'All Members',
                  top: 20.h,
                  bottom: 10.h,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
              GroupAllMembersWidget(
                totalMember: data.totalMembers!,
                members: data.members ?? [],
                onTap: (){
                  context.pushNamed(
                    AppRoutes.membersScreen,
                    extra: {
                      'members': data.members ?? [],
                      'communityId': data.id!,
                    },
                  );

                },
              ),
            ],

            /// Button
            const Spacer(),

            if(_controller.type.value != 'my')
            Obx(
                    () {
                      return _controller.isLoading.value ? const CustomLoader() : CustomButton(
                  onPressed: () {
                    if(data.alreadyJoined == true){
                      showDeleteORSuccessDialog(context,message:'Are you sure you want to leave this group?',onTap: (){
                        _controller.leaveGroup(context, data.id!);
                        context.pop();
                        context.pushNamed(AppRoutes.customBottomNavBar);
                        Get.find<CustomBottomNavBarController>().onChange(1);
                      },
                        title: 'Leave Group',
                        buttonLabel: 'leave',
                      );
                    }else{
                      _controller.joinCommunity(context,data.id!);

                    }
                  },
                  label: data.alreadyJoined ?? false ? 'Leave Group' : 'Join this Group',
                        backgroundColor: data.alreadyJoined ?? false ? AppColors.removeColor : AppColors.primaryColor,
                );
              }
            ),
          ],
        ),
      );
    });
  }

  Widget _buildShimmer() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 44.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Container(height: 20.h, width: 120.w, color: Colors.grey[300]),
            SizedBox(height: 8.h),
            Container(
                height: 14.h, width: double.infinity, color: Colors.grey[300]),
            SizedBox(height: 16.h),
            Container(
                height: 14.h, width: double.infinity, color: Colors.grey[300]),
            SizedBox(height: 16.h),
            Row(
              children: [
                CircleAvatar(radius: 24.r, backgroundColor: Colors.grey[300]),
                SizedBox(width: 12.w),
                Container(height: 16.h, width: 100.w, color: Colors.grey[300]),
              ],
            ),
            SizedBox(height: 36.h),
            Container(
              height: 48.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
