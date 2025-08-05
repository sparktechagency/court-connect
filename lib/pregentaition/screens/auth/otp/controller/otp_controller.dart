import 'dart:async';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  final otpCtrl = TextEditingController();

  final isLoading = false.obs;


  /// <==================otpSubmit function hare====================>

  Future<bool> otpSubmit(bool isSignUp) async {
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerTokenSignUp);

    RxBool isSuccess = false.obs;
    isLoading.value = true;

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    var bodyParams = {
      'otp': otpCtrl.text,
    };

    try {
      final response = await ApiClient.postData(
        ApiUrls.verifyOtp,
        headers: isSignUp ? mainHeaders : null,
        bodyParams,
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseBody['success'] == true) {
        isSuccess.value = true;
        otpCtrl.clear();
        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "OTP failed.");
      } else {
        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "OTP failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
    return isSuccess.value;
  }

  /// <==================resendOTP function hare====================>

  Future<void> resendOTP(
    BuildContext context,
  ) async {
    _startCountdown();
    try {
      final response = await ApiClient.postData(ApiUrls.resendOtp, {});

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "OTP sent to your email");
      } else {
        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "Otp failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {}
  }

  /// <==================time count function hare====================>
  final RxInt countdown = 180.obs;

  final RxBool isCountingDown = false.obs;

  void _startCountdown() {
    isCountingDown.value = true;
    countdown.value = 180;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
        isCountingDown.value = false;
      }
    });
  }

  @override
  void dispose() {
    otpCtrl.dispose();
    super.dispose();
  }
}
