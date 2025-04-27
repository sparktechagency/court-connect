import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/pregentaition/screens/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final NotificationController _controller = Get.put(NotificationController());

  @override
  void initState() {
    _controller.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Notification',
      ),



      body: Expanded(
        child: Obx(() {
            return ListView.builder(
              itemCount: _controller.notificationData.length,
                itemBuilder: (context,index) {

              if(_controller.isLoading.value){

              }

              if(_controller.notificationData.isEmpty){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image.asset('assets/images/noti_emt.png',height: 220.h,width: 220.w,),

                      CustomText(
                        top: 16.h,
                        maxline: 2,
                        text: 'There Are No Notifications Available',fontWeight: FontWeight.w500,fontsize: 20.sp,),


                      CustomText(
                        top: 16.h,
                        maxline: 4,
                        text: 'No notifications available at the moment, once it’s available, it will appear here.',fontWeight: FontWeight.w400,fontsize: 14.sp,color: Colors.grey,),
                    ],
                  ),
                );
              }
              return CustomContainer(
                radiusAll: 8.r,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 1),
                    blurRadius: 4,
                  )
                ],
                marginAll: 12.r,
                paddingAll: 16.r,
                  color: Colors.white,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CustomText(text: 'Notification',fontWeight: FontWeight.w600,),
                    CustomText(
                      textAlign: TextAlign.start,
                      text: _controller.notificationData[index].msg ?? '',fontsize: 12.sp,),
                  ],
                ),
              );


            }


            );
          }
        ),
      ),




    );
  }
}
