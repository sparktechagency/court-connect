import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegisteredUsersController extends GetxController {
  RxBool isLoading = false.obs;



  Future<void> getUser(BuildContext context,String id) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(ApiUrls.user(id));

      final responseBody = response.body;

      if (response.statusCode == 200 || responseBody['message'] == 'No users found for this session.') {
        context.pushNamed(AppRoutes.registeredUsersScreen);
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}