import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BookMarkController extends GetxController {
  RxBool isLoading = false.obs;
  RxString loadingSessionId = ''.obs;
  RxMap<String, bool> isBookedMap = <String, bool>{}.obs;
  RxMap<String, bool> isLoadingMap = <String, bool>{}.obs;





  Future<void> getBookMark(BuildContext context, String id) async {
    isLoadingMap[id] = true;
    isBookedMap[id] = false;

    try {
      final response = await ApiClient.postData(ApiUrls.bookmark(id),{});

      final responseBody = response.body;

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Assets.icons.bookingSuccess.svg(),
                  SizedBox(height: 24.h),
                  CustomText(
                    text: responseBody['message'] ?? 'Booking Successful!',
                    fontWeight: FontWeight.w500,
                    fontsize: 22.sp,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    onPressed: () {
                      context.pop();
                      isBookedMap[id] = true;  // Update booked state for this session only

                    },
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
      isLoadingMap[id] = false;
    }
  }
}