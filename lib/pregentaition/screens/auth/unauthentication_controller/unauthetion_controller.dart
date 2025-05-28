import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class UnauthetionController extends GetxController {


  final RxBool isLoading = false.obs;
  final RxBool isChecked = false.obs;


  Future<void> refreshToken(BuildContext context) async {
    isLoading.value = true;

    var bodyParams = {
      "email":HomeController().userEmail.value,
      "role":"user",
      "id": HomeController().userId.value
    };

    try {
      final response = await ApiClient.postData(
        ApiUrls.refreshToken,
        bodyParams,
        headers: {'Content-Type': 'application/json'},
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        final String? token = responseBody['data']?['token'];
        if (token != null) {
          debugPrint('====================> response token save: $token');
          await PrefsHelper.setString(AppConstants.bearerToken, token);
            context.goNamed(AppRoutes.customBottomNavBar);
          ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
        }
      } else {
        context.goNamed(AppRoutes.loginScreen);
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }






}
