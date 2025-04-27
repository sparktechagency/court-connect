import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: 'Notification',
      ),



      body: ListView.builder(itemBuilder: (context,index) {

        if(index == 0){
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
          marginAll: 12.r,
          paddingAll: 16.r,
            color: Colors.green[100],

          child: Text('Your payment has been processed successfully!'),
        );


      }


      ),




    );
  }
}
