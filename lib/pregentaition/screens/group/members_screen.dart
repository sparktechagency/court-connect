import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/group_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key, required this.members, required this.communityId});

  final List<Members> members;
  final String communityId;

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final GroupController controller = Get.put(GroupController());

    return CustomScaffold(
      appBar: const CustomAppBar(title: 'All Members'),
      body: Column(
        children: [
          SizedBox(height: 10.h),


          CustomTextField(
            controller: searchController,
            hintText: 'Search Name',
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: const Icon(Icons.search),
            ),
          ),


          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child:  CustomListTile(
                          image: member.image ?? '',
                          title: member.name ?? '',
                          trailing: CustomContainer(
                            onTap: (){
                              controller.removeMember(communityId, member.id!);
                            },
                            horizontalPadding: 16.w,
                            verticalPadding: 6.h,
                            color: AppColors.removeColor,
                            radiusAll: 12.r,
                            child: CustomText(
                              color: Colors.white,
                              fontsize: 10.sp,
                              text: 'Remove',
                            ),
                          ),
                        ),
                      );
                    },
            )
          ),
        ],
      ),
    );
  }
}
