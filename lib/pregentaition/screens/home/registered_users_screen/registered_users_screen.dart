import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/pregentaition/screens/home/registered_users_screen/controller/registered_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisteredUsersScreen extends StatefulWidget {
  const RegisteredUsersScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  State<RegisteredUsersScreen> createState() => _RegisteredUsersScreenState();
}

class _RegisteredUsersScreenState extends State<RegisteredUsersScreen> {
  late RegisteredUsersController _controller;


  @override
  void initState() {
    _controller = Get.put(RegisteredUsersController());
    _controller.getUser(widget.sessionId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.sessionId);
    return CustomScaffold(
      appBar: const CustomAppBar(title: 'Registered Users'),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Total Registered:',
                fontsize: 12.sp,
                color: Colors.grey,
              ),
              Obx(
                () {
                  return CustomText(
                    text: ' ${_controller.userDataList.length}people',
                    fontsize: 12.sp,
                    color: AppColors.primaryColor,
                  );
                }
              ),
            ],
          ),


          SizedBox(height: 16.h),
          Expanded(
            child: Obx(
              () {
                if(_controller.isLoading.value){
                  return const CustomLoader();
                }if(_controller.userDataList.isEmpty){
                  return Center(child: CustomText(text: 'No registered users',));
                }
                return ListView.builder(
                  itemCount: _controller.userDataList.length,
                  itemBuilder: (context, index) {
                    final user = _controller.userDataList[index];
                    final time = TimeFormatHelper.formatDate(DateTime.parse(user.bookingDate ?? ''));
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child:  CustomListTile(
                        image: user.image ?? '',
                        title: user.name ?? '',
                        subTitle: user.email ?? '',
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(text: 'Booking date:',fontsize: 10.sp,color: Colors.grey,),
                            CustomText(text: '$time ',fontsize: 12.sp,color: Colors.grey,),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
