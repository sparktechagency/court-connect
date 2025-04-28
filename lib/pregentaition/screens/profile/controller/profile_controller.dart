import 'dart:io';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/profile/models/my_profile_data.dart';
import 'package:courtconnect/pregentaition/screens/profile/models/other_profile_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<MyProfileData> _profileData = MyProfileData().obs;
  final nameTEController = TextEditingController();
  final phoneTEController = TextEditingController();
  final addressTEController = TextEditingController();
  final bioTEController = TextEditingController();
  var profileImage = Rx<File?>(null);

  MyProfileData get profileData => _profileData.value;

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
        _profileData.value = MyProfileData.fromJson(responseBody['data']);
      } else {
        ToastMessageHelper.showToastMessage("Failed to fetch profile data");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }








  Future<void> editProfile(BuildContext context) async {
    try {
      isLoading.value = true;


      final bodyParams = {
        "name": nameTEController.text.trim(),
        "phone": phoneTEController.text.trim(),
        "address": addressTEController.text.trim(),
        "bio": bioTEController.text.trim(),

      };

      List<MultipartBody>? multipartBody;
      if (profileImage.value != null) {
        multipartBody = [
          MultipartBody('image', profileImage.value!)
        ];
      }



      final response = await ApiClient.patchMultipartData(
          ApiUrls.updateProfile, bodyParams,
          multipartBody: multipartBody);
      final responseBody = response.body;

      final String? userName = responseBody['data']?['user']?['name'] ?? '';
      final String? userImage = responseBody['data']?['user']?['image'] ?? '';
      final String? bio = responseBody['data']?['user']?['boi'] ?? '';

      if (response.statusCode == 200 && responseBody['success'] == true) {
        await PrefsHelper.setString(AppConstants.name, userName);
        await PrefsHelper.setString(AppConstants.image, userImage);
        await PrefsHelper.setString(AppConstants.bio, bio);
        getMyProfile();
        context.pop();
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? '');

      } else {
        ToastMessageHelper.showToastMessage("Failed to fetch profile data");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    nameTEController.dispose();
    profileImage = null.obs;
    super.dispose();
  }

}
