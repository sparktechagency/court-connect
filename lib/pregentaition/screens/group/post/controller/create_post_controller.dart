import 'dart:io';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/post/controller/post_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CreatePostController extends GetxController {
  RxBool isLoading = false.obs;
  List<File> images = [];
  final TextEditingController descriptionController = TextEditingController();





  Future<void> createPost(BuildContext context,String id) async {
    ToastMessageHelper.showToastMessage('Your post is on its way, please wait a moment...');
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
        if ((response.statusCode == 200 || response.statusCode == 201) && responseBody['success'] == true) {
          ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
          _cleanField();
        } else {
          ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
          _cleanField();
        }
      } catch (e) {
        ToastMessageHelper.showToastMessage("Error: $e");
        _cleanField();
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
