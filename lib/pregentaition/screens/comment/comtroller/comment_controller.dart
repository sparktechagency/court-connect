
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/comment/models/commant_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  RxBool isLoading = false.obs;
  RxString limit = ''.obs;
  RxString postId = ''.obs;
  RxString comment = ''.obs;


  final RxList<CommentData> commentData = <CommentData>[].obs;






  Future<void> getComment(String id,type) async {
    commentData.clear();
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        ApiUrls.getComment(id,limit.value,type),
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        final List data = responseBody['data'];
        commentData.value = data.map((json) => CommentData.fromJson(json)).toList();
      } else {
        //ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
