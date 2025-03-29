import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/profile/models/my_profile_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<ProfileData> _profileData = ProfileData().obs;

  ProfileData get profileData => _profileData.value;

  @override
  void onInit() {
    super.onInit();
    getMyProfile();
  }

  Future<void> getMyProfile() async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrls.myProfile);
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        _profileData.value = ProfileData.fromJson(responseBody['data']);
      } else {
        ToastMessageHelper.showToastMessage("Failed to fetch profile data");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
