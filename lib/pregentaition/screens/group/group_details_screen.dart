import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/pregentaition/screens/group/widgets/group_all_member.dart';
import 'package:courtconnect/pregentaition/screens/group/widgets/group_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Group Details',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GroupCardWidget(
              title: 'Kingdom Youth',
              subTitle: '150 Members',
            ),
        
        

            CustomText(text: 'Description',bottom: 10.h,color: Colors.grey),
            CustomContainer(
              verticalPadding: 8.w,
              horizontalPadding: 16.w,
              radiusAll: 8.r,
              color: Colors.grey.shade300,
              child: CustomText(
                fontsize: 12.sp,
                textAlign: TextAlign.left,
                text: 'Lorem ipsum dolor sit amet consectetur. Sapien id viverra mauris arcu sit fusce lorem ullamcorper. Tellus habitasse fermentum quis etiam quis montes diam sapien suspendisse. Blandit velit venenatis urna dis aliquam sit donec. Nulla ut in neque amet pharetra purus purus.',
              ),
            ),
        
        
        
            CustomText(text: 'Group Creator',top: 16.h,fontWeight: FontWeight.w500,color: Colors.grey,),
            const CustomListTile(
              image: '',
              subTitle: '#User 12345',
              title: 'Alex James',
            ),
        
        
        
            CustomText(text: 'All Members',top: 16.h,fontWeight: FontWeight.w500,color: Colors.grey,bottom: 10.h,),
            const GroupAllMembersWidget(),
        
            SizedBox(height: 36.h),
            CustomButton(onPressed: (){
              context.pushNamed(AppRoutes.postScreen);
            },label: 'Join this Group',)
          ],
        ),
      ),
    );
  }
}
