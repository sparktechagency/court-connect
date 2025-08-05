import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/profile/models/my_session_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class MyBookingController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<MyBookingData> myBookings = <MyBookingData>[].obs;

  Future<void> getMyBooking() async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrls.booking);
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        myBookings.clear();
        final List data = responseBody['data'];
        myBookings.value =
            data.map((json) => MyBookingData.fromJson(json)).toList();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }





  Future<void> deleteMyBooking(String id) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.deleteData(ApiUrls.deleteBooking(id));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        myBookings.clear();
        getMyBooking();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
