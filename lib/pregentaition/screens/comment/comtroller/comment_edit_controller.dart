import 'dart:io';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/comment/comtroller/comment_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommentEditController extends GetxController {
  final RxBool isLoading = false.obs;



  final TextEditingController editCommentController = TextEditingController();
  List<File> images = [];






  Future<void> editComment(String postId,commentId) async {
    try {

      isLoading.value = true;

      final response =
      await ApiClient.patch(ApiUrls.editComment(postId,commentId), {
        'comment': editCommentController.text.trim(),
      },
      );
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        Get.find<CommentController>().getComment(postId,'recent');
        editCommentController.clear();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }






  Future<void> deleteComment(String postId,commentId) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.deleteData(ApiUrls.deleteComment(postId,commentId));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
        Get.find<CommentController>().getComment(postId,'recent');
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
    editCommentController.dispose();
    super.dispose();
  }
}
