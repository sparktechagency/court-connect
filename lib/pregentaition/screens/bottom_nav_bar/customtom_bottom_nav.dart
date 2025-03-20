import 'package:courtconnect/pregentaition/screens/home/home_screen.dart';
import 'package:courtconnect/pregentaition/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_container.dart';
import '../bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
import '../../../global/custom_assets/assets.gen.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final CustomBottomNavBarController _navBarController = Get.put(CustomBottomNavBarController());


  final List<Widget> _screens = const [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: _screens[_navBarController.selectedIndex.value],
          bottomNavigationBar: CustomContainer(
            elevation: true,
            verticalPadding: 10.h,
            color: Colors.white,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    _navItems.length, (index) => _buildNavItem(index)),
              ),
            ),
          ),
        ));
  }

  Widget _buildNavItem(int index) {
    bool isSelected = _navBarController.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => _navBarController.onChange(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            _navItems[index]["icon"],
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(height: 5.h),
          Text(
            _navItems[index]["label"],
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            height: 4.h,
            width: 30.w,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _navItems = [
    {"icon": Assets.icons.homeBottom.path, "label": "Home"},
    {"icon": Assets.icons.groupBottom.path, "label": "Group"},
    {"icon": Assets.icons.message.path, "label": "Message"},
    {"icon": Assets.icons.profileNav.path, "label": "Profile"},
  ];
}
