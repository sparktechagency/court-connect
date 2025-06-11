import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:courtconnect/services/get_fcm_token.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  final RxBool isLoading = false.obs;
  final RxBool isChecked = false.obs;

  void toggleChecked() => isChecked.toggle();

  Future<void> registerAccount(BuildContext context) async {
    isLoading.value = true;

    String? fcmToken = await FirebaseNotificationService.getFCMToken();


    var bodyParams = {
      'name': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text,
      'fcmToken': fcmToken ?? '',
    };




    try {
      final response = await ApiClient.postData(
        ApiUrls.register,
        bodyParams,
        headers: {'Content-Type': 'application/json'},
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        final String? token = responseBody['data']?['token'];
        if (token != null) {
          debugPrint('====================> response token save: $token');
          context.pushNamed(AppRoutes.otpScreen,pathParameters: {'screenType' : 'signupScreen'});
          _cleanTextField();
          ToastMessageHelper.showToastMessage(responseBody['message'] ?? "OTP sent to your email");
        }
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "Registration failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }



  void _cleanTextField (){
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    isChecked.value = false;
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
