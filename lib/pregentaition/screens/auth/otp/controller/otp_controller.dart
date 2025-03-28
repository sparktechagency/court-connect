import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OTPController extends GetxController {
  final  otpCtrl = TextEditingController();

  final isLoading = false.obs;

  Future<void> otpSubmit(BuildContext context) async {
    isLoading.value = true;

    var bodyParams = {
      'otp': otpCtrl.text,
    };

    try {
      final response = await ApiClient.postData(
        ApiUrls.verifyOtp,
        bodyParams,
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) && responseBody['success'] == true) {
        context.pushNamed(AppRoutes.loginScreen);
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "OTP failed.");
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "OTP failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    otpCtrl.dispose();
    super.dispose();
  }
}
