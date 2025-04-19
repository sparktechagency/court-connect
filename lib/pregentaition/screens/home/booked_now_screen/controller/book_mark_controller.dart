import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class BookMarkController extends GetxController {
  RxBool isLoading = false.obs;



  Future<void> getBookMark(String id) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(ApiUrls.bookmark(id),{});

      final responseBody = response.body;

      if (response.statusCode == 200 || responseBody['status'] == true) {
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