import 'dart:io';

import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SessionEditController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  File? coverImage;

  Future<void> editMySession(BuildContext context, String id) async {
    try {
      isLoading.value = true;

      final response =
          await ApiClient.patchMultipartData(ApiUrls.editSession(id), {
        'name': nameController.text.trim(),
      }, multipartBody: [
        MultipartBody('image', coverImage!),
      ]);
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        Get.find<HomeController>().getSession();
        nameController.clear();
        coverImage = null;
        context.pop();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteMySession(String id) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.deleteData(ApiUrls.deleteSession(id));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        Get.find<HomeController>().getSession();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    locationController.dispose();
    timeController.dispose();
    monthController.dispose();
    super.dispose();
  }
}
