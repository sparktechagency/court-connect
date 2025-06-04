import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:get/get.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';

class BlockUnblockController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isBlocked = false.obs;
  final RxString senderId = ''.obs;





  Future<void> blockUser(String receiverId,String chatId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(
        ApiUrls.blockUser(receiverId,chatId),
        {},
      );

      final responseBody = response.body;
      if (response.statusCode == 200) {
        isBlocked.value = true;
        senderId.value =  responseBody['data']?['senderId'] ?? '';
        PrefsHelper.setBool(AppConstants.isBlock, true);
        PrefsHelper.setString(AppConstants.senderId, senderId.value);
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



  Future<void> unblockUser(String receiverId,String chatId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(
        ApiUrls.unblockUser(receiverId,chatId),
        {},
      );

      final responseBody = response.body;
      if (response.statusCode == 200) {
        isBlocked.value = false;
        PrefsHelper.setBool(AppConstants.isBlock, false);
        ToastMessageHelper.showToastMessage('User unblocked successfully');

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
