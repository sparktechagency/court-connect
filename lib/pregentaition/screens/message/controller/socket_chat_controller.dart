import 'package:audioplayers/audioplayers.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
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
  ChatController _controller = Get.find<ChatController>();
  final AudioPlayer _audioPlayer = AudioPlayer();

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

        var prev = chatData.length;

        chatData.insert(0, demoData);





        var next = chatData.length;

        if (next > prev) {
          seenChat(data['chatId']);
        }

        debugPrint('=======================================>   ${demoData.isSender}');


        if(demoData.messageType == 'block'){

        }else{

        }
        if(demoData.messageType == 'block'){
          _controller.blockUnblock.value = {
            'lastMessageType': demoData.messageType,
            'blockId': demoData.senderId,
          };
        }else{
          _controller.blockUnblock.value = {
            'lastMessageType': demoData.messageType,
            'blockId': null,
          };
        }

        _controller.currentChatData.refresh();

      }
    });
  }


  /// ===============> Listen for user active status updates via socket.
  void listenActiveStatus() {
    socketService.socket.on("user-active-status", (data) {
      if (data != null) {
        print("=========> Socket active $data -------------------------");

        int index = chatListData.indexWhere((x) => x.receiver?.id == data['userId']);
        if (index != -1) {
          chatListData[index].receiver = chatListData[index].receiver?.copyWith(
                status: data["status"],
                name: data['name'],
                id: data['userId'],
              );


          chatListData.refresh();

          _controller.currentChatData['status'] = data['status'];
          _controller.currentChatData['name'] = data['name'];
          _controller.currentChatData.refresh();
          update();

          print('--------------------------status changed ');
        }
      }
    });
  }

  /// ===============> Listen for seen status updates via socket
  void listenSeenStatus(String chatId) {
    socketService.socket.on("check-seen", (data) async {
      print('==============> ====> ${data}');
      if (data != null) {
        int index = chatData.indexWhere((x) => x.sId == data['messageId']);
        print('==============> tanvir====> ${index}, ${data}');

        if (index != -1) {
      chatData[0].seenList?.insert(0, "bmnbnnv");


          chatData.refresh();
          chatListData.refresh();

          if(chatData[0].senderId != Get.find<HomeController>().userId.value){


            print('djlkfksjhgkjfs ========>   ');
            await _audioPlayer.play(AssetSource('audio/seen.mp3'));
          }

      update();
        }
      }
    });
  }

  void listenBlockUser() {
    socketService.socket.on("block-user", (data) {
      if (data != null) {

            print("=========> Response Data $data -------------------------");
            update();
      }
    });
  }

  void listenUnblockUser() {
    socketService.socket.on("unblock-user", (data) {
      if (data != null) {

            print("=========> Response Data $data -------------------------");
            update();
      }
    });
  }


  /// ================> Send a new message via socket.
  void sendMessage(String message, String receiverId) async {
    final body = {
      "message": message,
      "receiverId": receiverId,
    };
    socketService.emit('send-message', body);

    await _audioPlayer.play(AssetSource('audio/text_audio.mp3'));

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

  void blockUser(String receiverId) {
    final body = {"receiverId": receiverId};
    if (socketService.socket.connected) {
      socketService.emit('block-user', body);

    } else {
      socketService.socket.on('connect', (_) {
        socketService.emit('block-user', body);
      });
    }
  }

  void unblockUser(String receiverId) {
    final body = {"receiverId": receiverId};
    if (socketService.socket.connected) {
      socketService.emit('unblock-user', body);

    } else {
      socketService.socket.on('connect', (_) {
        socketService.emit('block-user', body);
      });
    }
  }

  /*/// ================> Handle unseen chat.
  void unseenChat(String chatId) {
    final body = {"chatId": chatId};
    if (socketService.socket.connected) {
      socketService.emit('check-unseen', body);
    } else {
      socketService.socket.on('connect', (_) {
        socketService.emit('check-unseen', body);
      });
    }
  }*/

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
