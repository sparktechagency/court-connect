import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/edit_group_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/group_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/widgets/group_card_widget.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final TextEditingController _searchController = TextEditingController();
  final GroupController _controller = Get.put(GroupController());
  final EditGroupController _editGroupController = Get.put(EditGroupController());

  final _sessionTypes = [
    {'label': 'Explore Groups', 'value': 'all'},
    {'label': 'Joined Groups', 'value': 'join'},
    {'label': 'My Creations', 'value': 'my'},
  ];


  @override
  void initState() {
    super.initState();
    _controller.scrollController.addListener(_controller.onScroll);
    _searchController.addListener(() {
      _controller.searchText.value = _searchController.text.toLowerCase();
    });

  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        showLeading: false,
        title: 'Community',
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(AppRoutes.createGroupScreen);
              },
              icon: const Icon(
                Icons.group_add_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        spacing: 16.h,
        children: [
          Obx(() {
            return TwoButtonWidget(
              fontSize: 12.sp,
              buttons: _sessionTypes,
              selectedValue: _controller.type.value,
              onTap: _controller.onChangeType,
            );
          }),
          CustomTextField(
            validator: (v) => null,
            borderRadio: 90.r,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: const Icon(Icons.search),
            ),
            controller: _searchController,
            hintText: 'Search Community...',
            contentPaddingVertical: 0,
          ),
          Expanded(child: Obx(() {
            if (_controller.isLoading.value) {
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => _buildShimmer(height: 280.h),
              );
            }

            if (_controller.filteredGroupList.isEmpty) {
              return const Center(child: Text("No Community available"));
            }
            return ListView.builder(
                itemCount: _controller.filteredGroupList.length,
                itemBuilder: (context, index) {
                  final data = _controller.filteredGroupList[index];
                  return GroupCardWidget(
                    menuItems: _controller.type.value == 'all'
                        ? []
                        : ['Edit', 'Delete', 'Group Info'],
                    onSelected: (val) {
                      if (val == 'Delete') {
                        showDeleteORSuccessDialog(context, onTap: () {
                          _editGroupController.deleteGroup(context, data.id!);
                        });
                      } else if (val == 'Edit') {
                        context.pushNamed(
                          AppRoutes.editGroupScreen,
                          extra: {
                            'id': data.id!,
                            'name': data.name ?? '',
                            'image':
                                '${ApiUrls.imageBaseUrl}${data.coverPhoto ?? ''}',
                            'des': data.description ?? '',
                          },
                        );
                      } else if (val == 'Group Info') {
                        context.pushNamed(AppRoutes.groupDetailsScreen, extra: {
                          'id': data.id!,
                        },
                        );
                      }
                    },
                    title: data.name ?? '',
                    subTitle: '${data.totalMembers} Members',
                    coverImage: '${ApiUrls.imageBaseUrl}${data.coverPhoto}',
                    detailAction: () {
                      context.pushNamed(AppRoutes.groupDetailsScreen, extra: {
                        'id': data.id!,
                      });
                    },


                    onTapPostAction: (){
                      if(_controller.type.value == 'join' || _controller.type.value == 'my'){
                        context.pushNamed(AppRoutes.postScreen,extra: {
                          'id': data.id!,
                        },);
                      }
                    },
                  );
                });
          }))
        ],
      ),
    );
  }

  Widget _buildShimmer({required double height}) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: const Duration(milliseconds: 800),
        child: CustomContainer(
          radiusAll: 8.r,
          height: height,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }
}
