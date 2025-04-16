import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> paymentParams(
      {
      required int amount,
      required String transactionId}) async {
    isLoading.value = true;

    var bodyParams = {"amount": amount, "transactionId": transactionId};

    try {
      final response = await ApiClient.postData(
        ApiUrls.paymentConfirm,
        bodyParams,
      );

      final responseBody = response.body;
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          responseBody['success'] == true) {
      } else {
        ToastMessageHelper.showToastMessage(
            responseBody['message'] ?? "Payment failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
