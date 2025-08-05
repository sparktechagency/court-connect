import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChangePassController extends GetxController{

  final  oldPassTEController = TextEditingController();
  final  passTEController = TextEditingController();
  final  rePassTEController = TextEditingController();
  RxBool isLoading = false.obs;
  
  
  Future<void> changePass(BuildContext context)async{
    
    isLoading.value = true;

    final requestBody = {
      "oldPassword":oldPassTEController.text,
      "newPassword":passTEController.text,
      "confirmPassword":rePassTEController.text,
    };
    
    try {
      final response = await ApiClient.postData(ApiUrls.changePassword, requestBody);

      final responseBody = response.body;
      if(response.statusCode == 200 && responseBody['success'] == true){
        context.pushReplacementNamed(AppRoutes.settingScreen);
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "Success");
      }else{
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "failed.");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    }finally{
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    oldPassTEController.dispose();
    passTEController.dispose();
    rePassTEController.dispose();
    super.dispose();
  }
}