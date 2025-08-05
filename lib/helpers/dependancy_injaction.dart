
import 'package:courtconnect/pregentaition/screens/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>CustomBottomNavBarController()) ;
    Get.put(HomeController());
    Get.put(HomeController());
  }


  void lockDevicePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}