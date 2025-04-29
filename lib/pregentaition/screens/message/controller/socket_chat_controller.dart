// import 'dart:convert';
// import 'dart:io';
// import 'package:courtconnect/core/utils/app_constants.dart';
// import 'package:courtconnect/helpers/prefs_helper.dart';
// import 'package:courtconnect/pregentaition/screens/message/models/chat_data.dart';
// import 'package:courtconnect/services/api_client.dart';
// import 'package:courtconnect/services/socket_services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ChatController extends GetxController{
//
//
//
//   RxInt unReadCount = 0.obs;
//
//
//
//   userActiveOff(){
//     PrefsHelper.setBool(AppConstants.userActive, false);
//   }
//
//
//
//   userActiveOn(){
//     PrefsHelper.setBool(AppConstants.userActive, true);
//   }
//
//
//   ///***************************************************************************
// //
//   RxList<ChatData> getChat = <ChatData>[].obs;
//   List chatIdList = [];
//
//   void listenMessage(String chatId) async {
//     var currentUserId = await PrefsHelper.getString(AppConstants.userId);
//     try {
//       SocketServices socketService = SocketServices();
//
//       socketService.socket.on("lastMessage::$chatId", (data) {
//         print("=========> Response Message: $data -------------------------");
//         if (data != null) {
//           ChatData demoData = ChatData.fromJson(data);
//           getChat.insert(0, demoData);
//
//           print("======================+++++++++****************************$currentUserId   ${demoData.senderId?.id}");
//           if(currentUserId != "${demoData.senderId?.id}"){
//             chatIdList.clear();
//           }
//           update();
//
//           print('Message added to chatMessages list');
//         } else {
//           print("No message data found in the response");
//         }
//       });
//     } catch (e, s) {
//       print("Error: $e");
//       print("Stack Trace: $s");
//     }
//   }
//
//   offSocket(String chatId) {
//     SocketServices socketService = SocketServices();
//     socketService.socket.off("lastMessage::$chatId");
//     debugPrint("Socket off New message");
//   }
//
//
//   // Send a message
//   void sendMessage(String message, String receiverId, String senderId, String chatId) {
//     final body = {
//       "message": "$message",
//       "receiverId": "$receiverId",
//       "senderId": "$senderId",
//       "chatId": "$chatId",
//     };
//     SocketServices socketService = SocketServices();
//     socketService.emit('send-message', body);
//   }
//
//
//
//
//   sendMessageWithImage(File? image, String receiverId)async{
//     String token = await PrefsHelper.getString(AppConstants.bearerToken);
//     List<MultipartBody> multipartBody =
//     image == null ? [] : [MultipartBody("image", image)];
//     var body = {
//       'messageType' : 'image',
//       'message' : 'image',
//       'receiverId' : '$receiverId',
//       // 'chatId' : '$chatId',
//     };
//     var headers = {
//       'Authorization': 'Bearer $token'
//     };
//     var response = await ApiClient.postMultipartData(
//         ApiConstants.sendMessageWithImage, body,
//         multipartBody: multipartBody, headers: headers);
//     if(response.statusCode == 200 || response.statusCode == 201){
//       getMessage(id: demoId.value);
//       getMessages.value;
//       update();
//       print("=================message send successful");
//     }else{
//     }
//   }
//
//
//
//
//   ///***************************************************************************
// //
//   ///===========Get Chat user list============>
//   RxBool getChatUserLoading = false.obs;
//   RxList<ChatListUserModel> chatListUsers = <ChatListUserModel>[].obs;
//   getChatUsers() async {
//     getChatUserLoading(true);
//
//     var response = await ApiClient.getData(ApiConstants.getChatUserList);
//     if (response.statusCode == 200) {
//       // chatListUsers.value = List<ChatListUserModel>.from(response.body["data"].map((x) => ChatListUserModel.fromJson(x)));
//       filteredChatList.value = List<ChatListUserModel>.from(response.body["data"].map((x) => ChatListUserModel.fromJson(x)));
//       getChatUserLoading(false);
//     } else {
//       getChatUserLoading(false);
//     }
//   }
//
//
//   RxList<ChatListUserModel> filteredChatList = <ChatListUserModel>[].obs;
//   void filterChats(String query) {
//     if (query.isEmpty) {
//       filteredChatList.value = chatListUsers;
//     } else {
//       filteredChatList.value = chatListUsers
//           .where((chat) =>
//           chat.participants!.any((participant) =>
//               participant.name!.toLowerCase().contains(query.toLowerCase())))
//           .toList();
//
//       update();
//     }
//   }
//
//
//
//
//
//
//
//   void listenLastMessage() async {
//     var currentUserId = await PrefsHelper.getString(AppConstants.userId);
//
//     try {
//       SocketServices socketService = SocketServices();
//
//       socketService.socket.on("message::$currentUserId", (data) async {
//
//         bool currentUserActive =await  PrefsHelper.getBool(AppConstants.userActive);
//
//         MessageModel demoData1 = MessageModel.fromJson(data);
//
//         if(currentUserId != "${demoData1.senderId?.id}"){
//
//           if(!chatIdList.contains(demoData1.chatId)){
//             chatIdList.add(demoData1.chatId);
//             unReadCount.value ++;
//           }
//
//
//
//           if(currentUserActive == false){
//             showNotification("${demoData1.message}", "${demoData1.senderId?.name}");
//           }
//         }
//         print("-----------------------------------$data");
//         update();
//
//       });
//     } catch (e, s) {
//       print("Error: $e");
//       print("Stack Trace: $s");
//     }
//   }
//
//
//
//
//
//   getUnreadUserCount() async {
//     var response = await ApiClient.getData(ApiConstants.unreadUserMessageCount);
//     if (response.statusCode == 200) {
//       unReadCount.value = response.body["data"]["unread"];
//     }
//   }
//
//
//
//
// }
