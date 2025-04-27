import 'dart:convert';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/controller/payment_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/utils/payment_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class StripePaymentSheet {
  final PaymentController _controller = Get.put(PaymentController());
  Map<String, dynamic>? _intentPaymentData;

  /// ===========> Step 1: Create PaymentIntent from Stripe API ===========>
  Future<Map<String, dynamic>?> _makeIntentForPayment(String amount) async {
    try {
      Map<String, dynamic> paymentInfoBodyParams = {
        'amount': (int.parse(amount) * 100).toString(),
        'currency': 'USD',
        'payment_method_types[]': 'card',
      };

      var responseFromStripeAPI = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: paymentInfoBodyParams,
        headers: {
          'Authorization': 'Bearer ${PaymentKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      debugPrint('response from api body =====> ${responseFromStripeAPI.body}');
      return jsonDecode(responseFromStripeAPI.body);
    } catch (e) {
      debugPrint("Error creating payment intent: =====> ${e.toString()}");
    }
    return null;
  }

  /// ===========> Step 2: Show Payment Sheet ===========>
  Future<void> _showPaymentSheet(
      {required BuildContext context, required String amount}) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) {
        final transactionId = _intentPaymentData?['id'] ?? 'Unknown';
        _intentPaymentData = null;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Payment Successful 🎉"),
            content: const Text("Your payment was successful."),
            actions: [
              Obx(
                () => _controller.isLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        onPressed: () {
                          _controller.paymentParams(
                            amount: int.parse(amount),
                            transactionId: transactionId,
                          );
                          context.pushNamed(AppRoutes.createSessionScreen);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Create Session"),
                      ),
              ),
            ],
          ),
        );
      }).onError((error, stackTrace) {
        debugPrint('❌ PaymentSheet Error: $error');
        ToastMessageHelper.showToastMessage("Oops! Payment failed. Please try again.");
      });
    } on StripeException catch (e) {
      debugPrint('❌ StripeException: ${e.error.localizedMessage}');
      ToastMessageHelper.showToastMessage(
          "StripeException: ${e.error.localizedMessage}");
    } catch (e) {
      debugPrint("❌ Error presenting payment sheet: ${e.toString()}");
      ToastMessageHelper.showToastMessage("Error: $e");
    }
  }

  /// ===========>   Step 3: Init Payment Sheet ===========>
  Future<void> paymentSheetInit({
    required String amount,
    required BuildContext context,
  }) async {
    try {
        Stripe.publishableKey = PaymentKeys.publishAbleKey; // <-- Add this
        await Stripe.instance.applySettings(); // <-- Add this

      _intentPaymentData = await _makeIntentForPayment(amount);

      if (_intentPaymentData == null ||
          _intentPaymentData!['client_secret'] == null) {
        debugPrint('PaymentIntent creation failed or missing client_secret');
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: _intentPaymentData!['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: await PrefsHelper.getString(AppConstants.name),
        ),
      );
      _showPaymentSheet(amount: amount, context: context);
    } catch (e) {
      debugPrint("Error initializing payment sheet: ${e.toString()}");
    }
  }
}
