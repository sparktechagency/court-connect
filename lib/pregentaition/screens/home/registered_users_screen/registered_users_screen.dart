import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisteredUsersScreen extends StatelessWidget {
  const RegisteredUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Registered Users'),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Total Registered:',
                fontsize: 12.sp,
                color: Colors.grey,
              ),
              CustomText(
                text: ' 30people',
                fontsize: 12.sp,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: const CustomListTile(
                    image: '',
                    title: 'Alex James',
                    subTitle: '#User 12345',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
