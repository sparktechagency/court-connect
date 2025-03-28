import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    isLoading.value = true;

    var bodyParams = {

      "email": emailController.text.trim(),
      "password": passwordController.text,
      "role":"user"


    };

    try {
      final response = await ApiClient.postData(
        ApiUrls.login,
        bodyParams,
        headers: {'Content-Type': 'application/json'},
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        final String? token = responseBody['data']?['token'];
        if (token != null) {
          debugPrint('====================> response token save: $token');
          await PrefsHelper.setString(AppConstants.bearerToken, token);
          context.pushNamed(AppRoutes.customBottomNavBar);
        }
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "Login failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
