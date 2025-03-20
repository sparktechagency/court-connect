import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/profile/widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            // Profile Picture and Name Section
            Center(
              child: Column(
                children: [
                  // Profile Picture with Outer Border and Shadow
                  CustomImageAvatar(
                    radius: 60.r,
                    image: '',
                  ),
                  SizedBox(height: 24.h),
                  CustomText(text: "Rakibul Hasan", fontsize: 18.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // List of Options
            ProfileListTile(
              icon: Assets.icons.profileEdit.svg(),
              title: "Edit Profile",
              onTap: () {
                context.pushNamed(AppRoutes.profileUpdate);
              },
            ),
            ProfileListTile(
              icon: Assets.icons.myBook.svg(),
              title: "My Booking",
              onTap: () {
                context.pushNamed(AppRoutes.myBookingScreen);
              },
            ),
            ProfileListTile(
              icon: Assets.icons.settings.svg(),
              title: "Settings",
              onTap: () {
                context.pushNamed(AppRoutes.settingScreen);
              },
            ),
            ProfileListTile(
              icon: Assets.icons.support.svg(),
              title: "Support",
              onTap: () {
                context.pushNamed(AppRoutes.supportScreen);
              },
            ),

            SizedBox(height: 44.h),

            // Log Out Button
            ProfileListTile(
              icon: Assets.icons.logOut.svg(),
              textColor: Colors.black,
              title: "Log Out",
              color: AppColors.logoutColor,
              noIcon: true,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: "Do you want to log out your profile?",
                    onCancel: () {
                      context.pop();
                    },
                    onConfirm: () {
                      context.go(AppRoutes.loginScreen);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}