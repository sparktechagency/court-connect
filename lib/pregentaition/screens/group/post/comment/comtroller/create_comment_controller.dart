import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/post/comment/comtroller/comment_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCommentController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController commentController = TextEditingController();





  Future<void> createComment(String id) async {
    isLoading.value = true;

    var bodyParams = {
      "comment": commentController.text.trim(),
    };

    try {

      final response = await ApiClient.postData(
        ApiUrls.commentCreate(id),
        bodyParams,
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) && responseBody['success'] == true) {
        
        _cleanField();
        Get.find<CommentController>().getComment(id);
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
    commentController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }
}
