import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../global/custom_assets/assets.gen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomContainer(
        elevation: true,
        verticalPadding: 10.h,
        color: Colors.white,
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Assets.icons.homeBottom.path, "Home", 0),
              _buildNavItem(Assets.icons.groupBottom.path, "Group", 1),
              _buildNavItem(Assets.icons.message.path, "Message", 2),
              _buildNavItem(Assets.icons.profileNav.path, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        height: 48.h,
        width: 60.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              width: 24.w,
              height: 24.h,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
            CustomContainer(
              verticalPadding: 2.h,
              horizontalPadding: 30.w,
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              topLeftRadius: 10.r,
              topRightRadius: 10.r,
            ),
          ],
        ),
      ),
    );
  }
}
