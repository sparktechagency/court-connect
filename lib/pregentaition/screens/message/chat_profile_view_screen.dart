import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatProfileViewScreen extends StatelessWidget {
  const ChatProfileViewScreen({super.key, required this.chatData});


  final Map<String,dynamic> chatData;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Hero(
              tag: chatData['heroTag'],
              child: CustomImageAvatar(
                image: chatData['image'],
                radius: 54.r,
              ),
            ),
          ),
          Center(child: CustomText(text: chatData['name'],top: 16.h,fontsize: 18.sp,fontWeight: FontWeight.w600,)),
          Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: 'Status: ',top: 6.h,fontsize: 10.sp,fontWeight: FontWeight.w500,),
              Flexible(child: CustomText(text: ' ${chatData['status']}',top: 6.h,fontsize: 10.sp,fontWeight: FontWeight.w600,color: chatData['status'] == 'online' ? Colors.green : Colors.amber)),
            ],
          )),



          SizedBox(height: 10.h),

          Divider(thickness: 0.2,color: Colors.black,),
          SizedBox(height: 24.h),
          CustomText(text: 'Bio : ',textAlign: TextAlign.start,fontWeight: FontWeight.w600,),
          CustomText(text: Get.find<HomeController>().bio.value,fontsize: 13.sp,),


          SizedBox(height: 24.h),
          CustomText(text: 'Email : ',textAlign: TextAlign.start,fontWeight: FontWeight.w600,),
          CustomText(text: chatData['email'],fontsize: 13.sp,),



          SizedBox(height: 44.h),
          GestureDetector(
            onTap: (){
              showDeleteORSuccessDialog(context, onTap: (){},title: 'Block ${chatData['name']}',buttonLabel: 'Block',message: 'Are you sure you want to block ${chatData['name']}? They will no longer be able to contact you.',
              );
            },
              child: CustomText(text: 'Block ${chatData['name']}',color: Colors.red,fontWeight: FontWeight.w600,)),

        ],
      ),
    );
  }
}
