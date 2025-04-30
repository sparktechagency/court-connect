import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_data.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_list_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:get/get.dart';
import '../../../../services/socket_services.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ChatListData> chatListData = <ChatListData>[].obs;
  RxList<ChatData> chatData = <ChatData>[].obs;
  SocketServices socketService = SocketServices();


  RxString seenStatus = ''.obs;
  RxBool socketSeen = false.obs;



  RxInt page = 1.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  var totalResult = (-1);






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

  Future<void> getChat(String receiverId,chatId) async {
    if(page.value == 1){
      chatData.clear();
      isLoading(true);
    }
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrls.getChatMessage(receiverId,chatId,'${page.value}'));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        totalPage = int.tryParse(responseBody['pagination']['totalPage'].toString()) ?? 0;
        currentPage = int.tryParse(responseBody['pagination']['currentPage'].toString()) ?? 0;
        totalResult = int.tryParse(responseBody['pagination']['totalItem'].toString()) ?? 0;

        List  data =  responseBody['data'];

        final chatList = data.map((json) => ChatData.fromJson(json)).toList();
        chatData.addAll(chatList);

      } else {
        ToastMessageHelper.showToastMessage("Failed to fetch profile data");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }


  void loadMore(String receiverId,chatId) {
    print("==========================================total page ${totalPage} page No: ${page.value} == total result ${totalResult}");
    if (totalPage > page.value) {
      page.value += 1;
      getChat(receiverId, chatId);
      print("**********************print here");
    }
    print("**********************print here**************");
  }

}
