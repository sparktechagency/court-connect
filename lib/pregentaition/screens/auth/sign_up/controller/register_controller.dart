import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/auth/otp/otp_screen.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool _isLoading = false.obs;
  final RxBool _isChecked = false.obs;


  RxBool get isLoading => _isLoading;
  RxBool get isChecked => _isChecked;



  void onChangedChecked (){
    isChecked.value = !isChecked.value;
  }


  Future<void> registerAccount(context) async {
    _isLoading.value = true;

    final body = {
      'name': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text,
    };

    try {
      final response = await ApiClient.postData(ApiUrls.register, body,
        headers: {'Content-Type': 'application/json'},
      );

      final bool isSuccess = response.body['success'];
      final String message = response.body['message'];
      final String token = response.body['data']['token'];

      if (response.statusCode == 200 || response.statusCode == 201 || isSuccess) {

        await PrefsHelper.setString(AppConstants.bearerToken, token);
        context.pushNamed(AppRoutes.otpScreen);
      }else{
        ToastMessageHelper.showToastMessage(message);
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage( "An unexpected error occurred: $e");
    } finally{
      _isLoading.value = false;
    }
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
