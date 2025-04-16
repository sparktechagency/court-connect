import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/utils/payment_keys.dart';

class PaymentController {
  Map<String, dynamic>? _intentPaymentData;

  // Step 1: Create PaymentIntent from Stripe API
  Future<Map<String, dynamic>?> _createPaymentIntent(String amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: {
          'amount': (int.parse(amount) * 100).toString(), // Amount in smallest unit
          'currency': currency,
          'payment_method_types[]': 'card',
        },
        headers: {
          'Authorization': 'Bearer ${PaymentKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint("PaymentIntent creation failed: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error creating PaymentIntent: $e");
    }
    return null;
  }

  // Step 2: Show Payment Sheet
  Future<void> _showPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) {
        debugPrint("Payment successful!");
        _showDialog(context, "Success", "Payment completed successfully!");
      }).onError((error, stackTrace) {
        debugPrint('PaymentSheet Error: $error');
        _showDialog(context, "Payment Error", "Something went wrong. Please try again.");
      });
    } on StripeException catch (e) {
      debugPrint('StripeException: ${e.error.localizedMessage}');
      _showDialog(context, "Cancelled", e.error.localizedMessage ?? "Payment was cancelled.");
    } catch (e) {
      debugPrint("Error presenting payment sheet: $e");
      _showDialog(context, "Error", "Something went wrong. Please try again.");
    }
  }

  // Helper to show dialogs
  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
      ),
    );
  }

  // Step 3: Initialize Payment Sheet
  Future<void> initPaymentSheet({
    required String amount,
    required String currency,
    required BuildContext context,
  }) async {
    _intentPaymentData = await _createPaymentIntent(amount, currency);

    if (_intentPaymentData == null || _intentPaymentData!['client_secret'] == null) {
      debugPrint('Failed to create PaymentIntent or missing client_secret');
      return;
    }

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        allowsDelayedPaymentMethods: true,
        paymentIntentClientSecret: _intentPaymentData!['client_secret'],
        style: ThemeMode.light,
        merchantDisplayName: 'Tanvir Hridoy',
      ),
    );

    // Show the payment sheet
    _showPaymentSheet(context);
  }
}
