import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool isLoading = false.obs;

  RxString aboutDescription = ''.obs;
  RxString termsDescription = ''.obs;
  RxString privacyDescription = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getAbout();
    _getTerms();
    _getPrivacy();
  }

  Future<void> _getAbout() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(ApiUrls.about,headers: {});

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        aboutDescription.value = responseBody['data']['description'] ?? '';
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> _getTerms() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(ApiUrls.terms,headers: {});

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        termsDescription.value = responseBody['data']['description'] ?? '';
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> _getPrivacy() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(ApiUrls.terms,headers: {});

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        privacyDescription.value = responseBody['data']['description'] ?? '';
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
