import 'dart:io';

import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_data.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_list_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_constants.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../services/socket_services.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ChatListData> chatListData = <ChatListData>[].obs;
  RxList<ChatData> chatData = <ChatData>[].obs;
  RxList<String> userList = <String>[].obs;
  RxList<String> statusList = <String>[].obs;





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
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrls.getChatMessage(receiverId,chatId));
      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {

        List  data =  responseBody['data'];

        chatData.value = data.map((json) => ChatData.fromJson(json)).toList();
      } else {
        ToastMessageHelper.showToastMessage("Failed to fetch profile data");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxInt unReadCount = 0.obs;

  userActiveOff(){
    PrefsHelper.setBool(AppConstants.userActive, false);
  }



  userActiveOn(){
    PrefsHelper.setBool(AppConstants.userActive, true);
  }


  ///***************************************************************************


  void listenMessage() async {
    var currentUserId = await PrefsHelper.getString(AppConstants.userId);


    try {
      SocketServices socketService = SocketServices();

      socketService.socket.on("new-message", (data) {
        print("=========> Response Message: $data -------------------------");
        if (data != null) {
          ChatData demoData = ChatData.fromJson(data);
          chatData.insert(0, demoData);


          debugPrint('=======================================   ${demoData.isSender}');


          update();

          print('Message added to chatMessages list');
        } else {
          print("No message data found in the response");
        }
      });
    } catch (e, s) {
      print("Error: $e");
      print("Stack Trace: $s");
    }
  }

  void listenActiveStatus() async {
    try {
      SocketServices socketService = SocketServices();

      socketService.socket.on("user-active-status", (data) {
        print("=========> Response Message: $data -------------------------");

        if (data != null) {

          userList.add(data['userId']);
          statusList.add(data['status']);
          update();

        } else {
          print("Invalid or null data received");
        }
      });
    } catch (e, s) {
      print("Error: $e");
      print("Stack Trace: $s");
    }
  }

  offSocket(String chatId) {
    SocketServices socketService = SocketServices();
    socketService.socket.off("lastMessage$chatId");
    socketService.socket.off("new-message");
    debugPrint("Socket off New message");
  }



  // Send a message
  void sendMessage(String message, String receiverId,
      // String senderId, String chatId
      ) {
    final body = {
      "message": "$message",
      "receiverId": "$receiverId",
      // "senderId": "$senderId",
      // "chatId": "$chatId",
    };
    SocketServices socketService = SocketServices();
    socketService.emit('send-message', body);
  }



  @override
  void onClose() {
    SocketServices socketService = SocketServices();
    socketService.socket.off("user-active-status");

    super.onClose();
  }

}


class User {
  final String userId;
  final String name;
  final String status;

  User({
    required this.userId,
    required this.name,
    required this.status,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      status: json['status'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'status': status,
    };
  }
}

