import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_list_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ChatListData> chatListData = <ChatListData>[].obs;



  Future<void> getChatList() async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrls.chatList);
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {

        List  data =  responseBody['data'];

        chatListData.value = data.map((json) => ChatListData.fromJson(json)).toList();
      } else {
        ToastMessageHelper.showToastMessage("Failed to fetch profile data");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }


}
