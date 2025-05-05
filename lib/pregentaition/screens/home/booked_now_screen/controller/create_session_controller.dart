import 'dart:io';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CreateSessionController extends GetxController {
  RxBool isLoading = false.obs;
  File? coverImage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();




  Future<void> createSession(BuildContext context) async {
    isLoading.value = true;

    var bodyParams = {
      "name": nameController.text.trim(),
      "price": priceController.text.trim(),
      "location": locationController.text.trim(),
      "date": monthController.text.trim(),
      "time": timeController.text.trim(),
    };

    try {
      final response = await ApiClient.postMultipartData(
        ApiUrls.sessionCreate,
        bodyParams,
          multipartBody: [
            MultipartBody('image', coverImage!),
          ]
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseBody['success'] == true) {
        context.goNamed(AppRoutes.customBottomNavBar);
        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "");
        _cleanField();
        Get.find<HomeController>().getSession();
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
    monthController.clear();
    timeController.clear();
    priceController.clear();
    locationController.clear();
    coverImage = null;

  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    monthController.dispose();
    timeController.dispose();
    priceController.dispose();
    locationController.dispose();
    coverImage = null;
  }
}
