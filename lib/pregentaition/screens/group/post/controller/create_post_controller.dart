import 'dart:io';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CreatePostController extends GetxController {
  RxBool isLoading = false.obs;
  List<File> images = [];
  final TextEditingController descriptionController = TextEditingController();





  Future<void> createGroup(BuildContext context,String id) async {
    if (descriptionController.text.trim().isEmpty && images.isEmpty) {
      ToastMessageHelper.showToastMessage('Description or Image is required.');
      return;
    }
    isLoading.value = true;

    var bodyParams = {
      "description": descriptionController.text.trim(),
    };

    try {
      List<MultipartBody> multipartFiles = images.map((image) {
        return MultipartBody('media', image);
      }).toList();

      final response = await ApiClient.postMultipartData(
        ApiUrls.postCreate(id),
        bodyParams,
        multipartBody: multipartFiles,
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseBody['success'] == true) {
        context.pushReplacementNamed(AppRoutes.postScreen);
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
        _cleanField();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _cleanField() {
    descriptionController.clear();
    images = [];
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
  }
}
