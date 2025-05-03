import 'package:get/get.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';

class BlockUnblockController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isUserBlocked = false.obs;

  Future<void> blockUser(String receiverId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(
        ApiUrls.blockUser(receiverId),
        {},
      );

      final responseBody = response.body;
      if (response.statusCode == 200) {
        isUserBlocked.value = true;
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
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
        isUserBlocked.value = false;
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
