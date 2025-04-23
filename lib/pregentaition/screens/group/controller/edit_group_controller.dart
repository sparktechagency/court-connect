import 'dart:io';

import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/controller/group_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EditGroupController extends GetxController {
  final RxBool isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  File? coverImage;






  Future<void> editMyGroup(BuildContext context, String id) async {
    try {
      isLoading.value = true;

      final response =
      await ApiClient.patchMultipartData(ApiUrls.editGroup(id), {
        'name': nameController.text.trim(),
      }, multipartBody: [
        MultipartBody('photo', coverImage!),
        MultipartBody('coverPhoto', coverImage!),
      ]);
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        Get.find<GroupController>().getGroup();
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





  Future<void> deleteGroup(BuildContext context,String id) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.deleteData(ApiUrls.deleteGroup(id));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
        context.pop();
        Get.find<GroupController>().getGroup();
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
    desController.dispose();
    super.dispose();
  }
}
