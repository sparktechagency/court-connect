import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../core/utils/app_colors.dart';


class ToastMessageHelper{
  static void showToastMessage(String message, {int? secound,Color? actionColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: secound ?? 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.h,
    );


    /*Get.snackbar('', message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(204, 255, 255, 255),
        colorText: Colors.black,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration:  Duration(seconds: secound ?? 3),
        leftBarIndicatorColor: actionColor);*/
  }
}