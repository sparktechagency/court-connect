import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/bottom_nav_bar/customtom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/widgets/custom_dialog.dart';
import '../../../core/widgets/custom_network_image.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../services/api_constants.dart';



class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {



  String? name;
  String? email;
  String? image;



  @override
  void initState() {
    getLocalData();
    super.initState();
  }


  getLocalData() async {
    name = await PrefsHelper.getString(AppConstants.name);
    email = await PrefsHelper.getString(AppConstants.email);
    image = await PrefsHelper.getString(AppConstants.image);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(height: 50.h,),
                // Profile Picture and Name Section
                Center(
                  child: Column(
                    children: [
                      // Profile Picture with Outer Border and Shadow
                      Container(
                        width: 120.r,
                        height: 120.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10.r,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          border: Border.all(
                            color: AppColors.primaryColor.withOpacity(0.5), // Outer blue border
                            width: 2.w,
                          ),
                        ),
                        child:
                        CustomNetworkImage(
                            boxShape: BoxShape.circle,
                            imageUrl: (image != null && image!.isNotEmpty)
                                ? "${ApiConstants.imageBaseUrl}/${image!}"
                                : "https://templates.joomla-monster.com/joomla30/jm-news-portal/components/com_djclassifieds/assets/images/default_profile.png",
                            height: 86.h, width: 86.w
                        ),

                        // CircleAvatar(
                        //   radius: 50.r,
                        //   backgroundColor: Colors.grey[300],
                        //   child: Image.asset(
                        //     AppIcons.person, // Your person icon
                        //     height: 50.h,
                        //     width: 50.w,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ),
                      SizedBox(height: 10.h),
                      // Profile Name with Verified Icon
                      CustomText(text: "XYZ",  fontsize: 20.h),


                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // List of Options
                Column(
                  children: [
                    _buildProfileOption(
                      icon: Assets.icons.myBook.svg(),
                      title: "Profile details",
                      onTap: () {
                        // Get.toNamed(AppRoutes.profileUpdate, arguments: {
                        //   'name' : name ?? "XYZ",
                        //   "email" : email ?? "xyz@gmail.com",
                        //   "image" : image ?? "https://templates.joomla-monster.com/joomla30/jm-news-portal/components/com_djclassifieds/assets/images/default_profile.png",
                        // });
                      },
                    ),

                    _buildProfileOption(
                      icon: Assets.icons.settings.svg(),
                      title: "Settings",
                      onTap: () {
                       // Get.toNamed(AppRoutes.settingScreen);
                      },
                    ),
                    _buildProfileOption(
                      icon: Assets.icons.support.svg(),
                      title: "Support",
                      onTap: () {
                       // Get.toNamed(AppRoutes.supportScreen);
                      },
                    ),
                  ].whereType<Widget>().toList(),
                ),

                SizedBox(height: 20.h),

                // Log Out Button
                _buildProfileOption(
                  icon: Assets.icons.logOut.svg(),
                  textColor: Colors.white,
                  title: "Log Out",
                  color: AppColors.primaryColor,
                  iconColor: Colors.white,


                  noIcon: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: "Do you want to log out your profile?",
                        onCancel: () {
                          // Handle Cancel Button Action
                          Get.back();
                        },
                        onConfirm: () {

                         // Get.offAllNamed(AppRoutes.onboardingScreen);
                        },
                      ),
                    );

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for Profile Option
  Widget _buildProfileOption({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
    Color?textColor,
    Color?iconColor,
    Color? color,
    bool? noIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: color ?? Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(width: 12.w),
              Expanded(
                child: CustomText(
                  text: title,
                  textAlign: TextAlign.start,
                  color:textColor?? AppColors.textColor363636 ,
                  fontsize: 14.sp,
                ),
              ),
              if (noIcon != true)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.h,
                  color:Colors.black,
                ),
            ],
          ),
        ),
      ),
    );
  }
}