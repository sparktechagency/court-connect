import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';

class BlockUnblockController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isBlocked = false.obs;
  final ChatController _chatController =  Get.put(ChatController());





  Future<void> blockUser(String receiverId,senderId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(
        ApiUrls.blockUser(receiverId),
        {},
      );

      final responseBody = response.body;
      if (response.statusCode == 200) {
        isBlocked.value = true;
        ToastMessageHelper.showToastMessage('User blocked successfully');

      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? 'Failed to block user');
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> unblockUser(String receiverId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(
        ApiUrls.unblockUser(receiverId),
        {},
      );

      final responseBody = response.body;
      if (response.statusCode == 200) {
        ToastMessageHelper.showToastMessage('User unblocked successfully');
        isBlocked.value = false;

      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? 'Failed to unblock user');
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
