
import 'package:courtconnect/pregentaition/screens/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
import 'package:get/get.dart';

class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>CustomBottomNavBarController()) ;
  }
}