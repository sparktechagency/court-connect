import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/controller/setting_controller.dart';
import 'package:courtconnect/pregentaition/screens/profile/widgets/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/widgets/custom_dialog.dart';
import 'package:get/get.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final SettingController _controller = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          children: [
            ProfileListTile(
              icon: const Icon(Icons.lock,color: Colors.black),
              title: "Change Password",
              onTap: () {
                context.pushNamed(AppRoutes.changePassword);
              },
            ),
            ProfileListTile(
              icon: Assets.icons.terms.svg(),
              title: "Terms & Conditions",
              onTap: () {
                context.pushNamed(AppRoutes.termsScreen);
              },
            ),
            ProfileListTile(
              icon: Assets.icons.privacy.svg(),
              title: "Privacy Policy",
              onTap: () {
                context.pushNamed(AppRoutes.privacyPolicyScreen);
              },
            ),
          ProfileListTile(
              icon: Assets.icons.about.svg(),
              title: "About Us",
              onTap: () {
                context.pushNamed(AppRoutes.aboutScreen);
              },
            ),

            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: ProfileListTile(
                icon: const Icon(Icons.delete_outline,color: Colors.red),
                  title: 'Delete Account',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: "Do you want to delete your account ?",
                        confirmButtonText: 'Delete',
                        confirmButtonColor: Colors.red,
                        onCancel: () {
                          context.pop();
                        },
                        onConfirm: () {
                          _controller.deleteAccount(context, Get.find<HomeController>().userId.value);
                        },
                      ),
                    );
                  },
                  noIcon: true,
                  color: Colors.red.withOpacity(0.2),
                  textColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}