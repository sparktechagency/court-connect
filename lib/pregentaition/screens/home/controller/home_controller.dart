import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/home/models/banner_data.dart';
import 'package:courtconnect/pregentaition/screens/home/models/session_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString userName = ''.obs;
  RxString type = 'all'.obs;
  RxString price = ''.obs;
  RxString date = ''.obs;
  RxString id = ''.obs;
  RxBool isLoading = false.obs;


  RxInt charge = 0.obs;

  RxList<BannerData> bannerList = <BannerData>[].obs;
  RxList<SessionData> sessionList = <SessionData>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getUserName();
    _getBanner();
    getSession();
    getCharge();
  }

  void _getUserName() async {
    userName.value = await PrefsHelper.getString(AppConstants.name);
  }

  /// <==================== Get Banner Data ======================>
  Future<void> _getBanner() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(ApiUrls.getBanner);

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        List data = responseBody['data'] ?? [];
        bannerList.value = data.map((e) => BannerData.fromJson(e)).toList();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// <==================== get Session Data ======================>


  Future<void> getSession() async {
    sessionList.clear();
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
          ApiUrls.session(type.value, price.value, date.value));

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        List data = responseBody['data'] ?? [];
        sessionList.value = data.map((e) => SessionData.fromJson(e)).toList();
      } else{
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> getCharge() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
          ApiUrls.charge);

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        charge.value = responseBody['data']['charge'];

    } else{
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onChangeType(String newType) {
    type.value = newType;
    getSession();
  }
}
