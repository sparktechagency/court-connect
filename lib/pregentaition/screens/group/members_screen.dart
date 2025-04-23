import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/group_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key, required this.members, required this.communityId});

  final List<Members> members;
  final String communityId;

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final searchController = TextEditingController();
  final GroupController controller = Get.put(GroupController());

  late List<Members> filteredMembers;


  @override
  void initState() {
    super.initState();
    filteredMembers = widget.members;

    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredMembers = widget.members.where((member) {
          final name = member.name?.toLowerCase() ?? '';
          return name.contains(query);
        }).toList();
      });
    });
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      appBar: const CustomAppBar(title: 'All Members'),
      body: Column(
        children: [
          SizedBox(height: 10.h),


          CustomTextField(
            validator: (val){
              return null;
            },
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
              itemCount: filteredMembers.length,
              itemBuilder: (context, index) {
                final member = filteredMembers[index];
                return CustomListTile(
                  onTap: (){
                    context.pushNamed(AppRoutes.otherProfileScreen,extra: {
                      'id' : member.id!,
                    });
                  },
                  image: member.image ?? '',
                  title: member.name ?? '',
                  subTitle: member.email ?? '',
                  trailing: controller.type.value == 'my'
                      ? CustomContainer(
                    onTap: () {
                      showDeleteORSuccessDialog(context, onTap: (){
                        controller.removeMember(context, widget.communityId, member.id!);

                      },
                        title: 'Remove',
                        buttonLabel: 'Remove'
                      );
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
                  )
                      : null,
                );
              },
            ),
          ),        ],
      ),
    );
  }

}
