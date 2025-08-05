import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../models/other_profile_data.dart';

class OtherProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isButtonLoading = false.obs;
  final Rx<OtherProfileData> otherProfileData = OtherProfileData().obs;





  Future<void> createChat(BuildContext context,String receiverId,Map<String,dynamic>chatData) async {
    isButtonLoading.value = true;


    try {
      final response = await ApiClient.postData(
          ApiUrls.createChat(receiverId),
          {},
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) && responseBody['success'] == true) {
        context.goNamed(AppRoutes.customBottomNavBar);
        Get.find<CustomBottomNavBarController>().onChange(2);
        /*context.pushReplacementNamed(AppRoutes.chatScreen,extra: {
          'image' : chatData['image'] ?? '',
          'name' : chatData['name'] ?? '',
          'email' : chatData['email'] ?? '',
        });*/
      } else {

        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isButtonLoading.value = false;
    }
  }



  Future<void> getOtherProfile(String id) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrls.otherProfile(id));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        otherProfileData.value = OtherProfileData.fromJson(responseBody['data']);
      } else {
        ToastMessageHelper.showToastMessage("Failed to fetch profile data");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
