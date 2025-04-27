import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/profile/other_profile/controller/other_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({super.key, required this.id});

  final String id;

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  final OtherProfileController _controller = Get.put(OtherProfileController());

  @override
  void initState() {
    super.initState();
    _controller.getOtherProfile(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile Details'),
      body: SafeArea(
        child: Obx(() {
          if (_controller.isLoading.value) {
            return _buildShimmer();
          }

          final data = _controller.otherProfileData.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(height: 240.h),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Assets.images.otherProfileCover.image(),
                  ),
                  Positioned(
                    bottom: 0,
                    child: CustomImageAvatar(
                      radius: 50.r,
                      image: data.image ?? '',
                    ),
                  ),
                ],
              ),




              Center(
                child: CustomText(
                  text: data.name ?? 'N/A',
                  fontsize: 30.sp,
                  fontWeight: FontWeight.w500,
                  top: 10.h,
                ),
              ),
              Center(child: CustomText(text: data.email ?? 'N/A', top: 6.h)),
              _buildField(title: 'Phone', value: data.phone),
              _buildField(title: 'Address', value: data.address),
              _buildField(title: 'Bio', value: data.bio, maxLines: 7),






              const Spacer(),
              Center(
                child: Obx(
                  () {
                    return _controller.isButtonLoading.value ? CustomLoader() : CustomContainer(
                      onTap: () {
                        _controller.createGroup(context, data.sId!,{
                          'image' : data.image ?? '',
                          'name' : data.name ?? '',
                        });
                      },
                      paddingAll: 10.r,
                      radiusAll: 8.r,
                      width: 170.w,
                      color: AppColors.primaryColor,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              color: Colors.white,
                              text: 'Send Message',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Assets.icons.messageIcons.svg(),
                          SizedBox(width: 6.w)
                        ],
                      ),
                    );
                  }
                ),
              ),


              SizedBox(height: 24.h),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildField({required String title, String? value, int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: title, fontWeight: FontWeight.w600, fontsize: 12.sp),
          CustomText(
            text: value?.isNotEmpty == true ? value! : 'N/A',
            fontsize: 12.sp,
            color: Colors.grey,
            top: 6.h,
            maxline: maxLines,
          ),
        ],
      ),
    );
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
