import 'dart:io';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/group_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CreateGroupController extends GetxController {
  RxBool isLoading = false.obs;
  File? coverImage;
  File? profileImage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();




  Future<void> createGroup(BuildContext context) async {
    isLoading.value = true;

    var bodyParams = {
      "name": nameController.text.trim(),
      "description": descriptionController.text.trim(),
    };

    try {
      final response = await ApiClient.postMultipartData(
          ApiUrls.communityCreate,
          bodyParams,
          multipartBody: [
            MultipartBody('photo', profileImage!),
            MultipartBody('coverPhoto', coverImage!),
          ]
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseBody['success'] == true) {
        context.pushReplacementNamed(AppRoutes.customBottomNavBar);
        Get.find<CustomBottomNavBarController>().onChange(1);
        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "");
        _cleanField();
        Get.find<GroupController>().getGroup();
      } else {

        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }



  void _cleanField(){
    nameController.clear();
    descriptionController.clear();
    profileImage = null;
    coverImage = null;

  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    profileImage = null;
    coverImage = null;
  }
}
