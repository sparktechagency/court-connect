import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:courtconnect/services/internet/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../global/custom_assets/assets.gen.dart';
import 'custom_text.dart';

class NoInterNetScreen extends StatelessWidget {
  final bool? isToast;
  final bool? isAppBar;
  final Widget child;

  const NoInterNetScreen(
      {super.key,
        required this.child,
        this.isToast = false,
        this.isAppBar = true});

  @override
  Widget build(BuildContext context) {
    // Retrieve the ConnectivityService instance
    final ConnectivityController connectivityService = Get.put(ConnectivityController());

    return Stack(
      children: [

        // child,

        Obx(() {
          if (!connectivityService.isConnected.value) {
            return isToast == false
                ? Container(
              color: Colors.black45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.lottie.noInternet.lottie(),

                  SizedBox(height: 30.h),

                  CustomText(
                      text: "Oops!",
                      fontsize: 30.h,
                      color: Colors.red,
                      top: 10.h,
                      fontWeight: FontWeight.w800,
                      bottom: 10.h),
                  CustomText(
                    text:
                    "There was some problem, Check your connection and try again",
                    maxline: 3,
                    left: 30.w,
                    right: 30.w,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            )
                : Positioned(
              top: isAppBar == true ? 50 : -5,
              right: 0,
              left: 0,
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 22.w, vertical: 6.h),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8.w),
                      const Text(
                        'No Internet Connection',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return child;
          }
        }),

      ],
    );
  }
}
