import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/post/models/post_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  RxBool isLoading = false.obs;
  RxString type = 'all'.obs;
  RxString page = ''.obs;
  RxString limit = ''.obs;
  RxString date = ''.obs;
  RxString communityId = ''.obs;


  final RxList<PostData> postDataList = <PostData>[].obs;





  Future<void> getPost() async {
    postDataList.clear();
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        ApiUrls.post(communityId.value, page.value, limit.value, type.value),
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        final List data = responseBody['data'];
        postDataList.value = data.map((json) => PostData.fromJson(json)).toList();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }




  void onChangeType(String newType) {
    type.value = newType;
    getPost();
  }
}
