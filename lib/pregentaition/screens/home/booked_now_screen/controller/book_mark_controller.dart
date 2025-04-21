import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BookMarkController extends GetxController {
  RxBool isLoading = false.obs;
  RxString loadingSessionId = ''.obs;



  Future<void> getBookMark(BuildContext context, String id) async {
    loadingSessionId.value = id;
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(ApiUrls.bookmark(id),{});

      final responseBody = response.body;

      if ((response.statusCode == 200 || response.statusCode == 201) || responseBody['errorType'] == 'Bad Request') {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(responseBody['errorType'] == 'Bad Request')
                  Assets.icons.bookingError.svg(),
                  if((response.statusCode == 200 || response.statusCode == 201))
                  Assets.icons.bookingSuccess.svg(),
                  SizedBox(height: 24.h),
                  CustomText(
                    text: responseBody['message'] ?? 'Booking Successful!',
                    fontWeight: FontWeight.w500,
                    fontsize: 22.sp,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    onPressed: () => context.pop(),
                    label: 'Go Back',
                    width: 160.w,
                    radius: 8.r,
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? '');
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
      loadingSessionId.value = '';    }
  }
}