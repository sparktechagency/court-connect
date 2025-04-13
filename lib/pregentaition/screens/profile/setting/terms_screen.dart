
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/pregentaition/screens/profile/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;
    final SettingController controller = Get.put(SettingController());

    return Scaffold(
      appBar: const CustomAppBar(title: "Terms & Condition"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Padding(
            padding: EdgeInsets.all(sizeH * .02),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              period: const Duration(milliseconds: 800),
              child: Center(
                child: Container(
                  height: sizeH * 0.8,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else {
          return ListView(
            padding: EdgeInsets.all(sizeH * .02),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(height: sizeH * .01),
              HtmlWidget(
                controller.termsDescription.value,
                textStyle: TextStyle(fontSize: 14.sp),
              ),
            ],
          );
        }
      }),
    );
  }

}
