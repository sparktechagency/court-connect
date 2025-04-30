import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_data.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_list_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../services/socket_services.dart';

class SocketChatController extends GetxController {
  RxList<ChatListData> chatListData = Get.find<ChatController>().chatListData;
  RxList<ChatData> chatData = Get.find<ChatController>().chatData;
  SocketServices socketService = SocketServices();
  RxBool socketSeen = false.obs;

  userActiveOff() {
    PrefsHelper.setBool(AppConstants.userActive, false);
  }

  userActiveOn() {
    PrefsHelper.setBool(AppConstants.userActive, true);
  }

  /// ===============> Listen for new messages via socket.
  void listenMessage() async {
    socketService.socket.on("new-message", (data) {
      print("=========> Response Message: $data -------------------------");

      if (data != null) {
        ChatData demoData = ChatData.fromJson(data);

        chatData.insert(0, demoData);


        debugPrint('=======================================>   ${demoData.isSender}');

        update();
      }
    });
  }

  /// ===============> Listen for user active status updates via socket.
  void listenActiveStatus() {
    socketService.socket.on("user-active-status", (data) {
      if (data != null) {
        print("=========> Response Message: $data -------------------------");

        int index = chatListData.indexWhere((x) => x.receiver?.id == data['userId']);
        if (index != -1) {
          chatListData[index].receiver = chatListData[index].receiver?.copyWith(
                status: data["status"],
                name: data['name'],
                id: data['userId'],
              );
          chatListData.refresh();
          update();

          print('--------------------------status changed ');
        }
      }
    });
  }

  /// ===============> Listen for seen status updates via socket
  void listenSeenStatus(String chatId) {
    socketService.socket.on("check-seen", (data) {
      if (data != null) {
        int index = chatData.indexWhere((x) => x.chatId == chatId);
        if (index != -1) {
          bool isSeen = chatData[index].seenList?.contains(chatData[index].receiverId) ?? false;

          if (isSeen) {
            socketSeen.value = true;
            print("=========> Chat marked as seen -------------------------");
          } else {
            socketSeen.value = false;
            print("=========> Chat marked as unseen -------------------------");
          }
          chatData.refresh();
          update();
        }
      }
    });
  }

  void listenUnseenStatus(String chatId) {
    socketService.socket.on("check-unseen", (data) {
      if (data != null) {
        int index = chatData.indexWhere((x) => x.chatId == chatId);
        if (index != -1) {
          bool isUnseen = !(chatData[index].seenList?.contains(chatData[index].receiverId) ?? false);

          if (isUnseen) {
            print("=========> Chat marked as unseen -------------------------");
          }

          chatData.refresh();
          update();
        }
      }
    });
  }


  /// ================> Send a new message via socket.
  void sendMessage(String message, String receiverId) {
    final body = {
      "message": message,
      "receiverId": receiverId,
    };
    socketService.emit('send-message', body);
  }

  /// ================> Handle seen chat.
  void seenChat(String chatId) {
    final body = {"chatId": chatId};
    if (socketService.socket.connected) {
      socketService.emit('check-seen', body);
    } else {
      socketService.socket.on('connect', (_) {
        socketService.emit('check-seen', body);
      });
    }
  }

  /// ================> Handle unseen chat.
  void unseenChat(String chatId) {
    final body = {"chatId": chatId};
    if (socketService.socket.connected) {
      socketService.emit('check-unseen', body);
    } else {
      socketService.socket.on('connect', (_) {
        socketService.emit('check-unseen', body);
      });
    }
  }

  /// ===================> Turn off specific socket events when the chat is closed
  void offSocket(String chatId) {
    socketService.socket.off("lastMessage$chatId");
    socketService.socket.off("new-message");
    socketService.socket.off("check-seen");
    socketService.socket.off("check-unseen");
    debugPrint("Socket off seen");
    debugPrint("Socket off unseen");
    debugPrint("Socket off New message");
  }

}
