import 'dart:io';
import 'package:courtconnect/core/app_routes/app_routes.dart';
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
  final Rx<ProfileData> _profileData = ProfileData().obs;
  final Rx<OtherProfileData> otherProfileData = OtherProfileData().obs;
  final nameTEController = TextEditingController();
  File? profileImage;

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



  Future<void> getOtherProfile(String id) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrls.otherProfile(id));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        otherProfileData.value = OtherProfileData.fromJson(responseBody['data']);
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

      final response = await ApiClient.patchMultipartData(
          ApiUrls.updateProfile, {"name": nameTEController.text.trim()},
          multipartBody: [
            MultipartBody('image', profileImage!)
          ]);
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        context.pushNamed(AppRoutes.customBottomNavBar);
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
    profileImage = null;
    super.dispose();
  }

}
