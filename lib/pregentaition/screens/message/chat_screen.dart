import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/block_unblock_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/socket_chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/models/chat_list_data.dart';
import 'package:courtconnect/pregentaition/screens/message/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../home/controller/home_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatData});

  final Map<String, dynamic> chatData;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final _chatController = Get.put(ChatController());
  final _socketChatController = Get.put(SocketChatController());
  final _blockUnblockController = Get.put(BlockUnblockController());

  String userId = '';

  @override
  void initState() {
    super.initState();
    _chatInit();
  }

  void _chatInit() async {
    userId = await PrefsHelper.getString(AppConstants.userId);
    _socketChatController.listenActiveStatus();
    _socketChatController.listenMessage();
    //_socketChatController.messageDelete();
    _socketChatController.seenChat(widget.chatData['chatId'] ?? '');
    _socketChatController.listenSeenStatus(widget.chatData['chatId'] ?? '');
    _addScrollListener();
    _chatController.getChat(widget.chatData['receiverId'] ?? '', widget.chatData['chatId'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    var receiver = _chatController.chatListData[widget.chatData['index'] ?? ''].receiver;
    return CustomScaffold(
      appBar: CustomAppBar(
        titleWidget: Obx(() {
          final bool isBlocked = _chatController.chatData.isNotEmpty? _chatController.chatData[0].messageType == 'block' : false;

          var receiver = _chatController.chatListData[widget.chatData['index'] ?? ''].receiver;
          return Hero(
              tag: widget.chatData['index'] ?? '',
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(
                    AppRoutes.chatProfileViewScreen,
                    extra: {
                      'index' : widget.chatData['index'] ?? '',
                      'chatId' : widget.chatData['chatId'] ?? ''
                    },
                  );
                },
                child: CustomListTile(
                  imageRadius: 20.r,
                  image: receiver?.image ?? '',
                  title:receiver?.name ?? '',
                  subTitle: !isBlocked && receiver?.status == 'online'
                      ? 'online'
                      : TimeFormatHelper.getTimeAgo(
                          DateTime.tryParse(receiver?.lastActive ?? '') ??
                              DateTime.now()),
                  statusColor: !isBlocked && receiver?.status == 'online' ? Colors.green : Colors.grey,
                ),
              ),
            );
          }
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h),
          Expanded(
            child: Obx(
              () {
                return ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  reverse: true,
                  itemCount: _chatController.chatData.length,
                  itemBuilder: (context, index) {
                    if (_chatController.isLoading.value) {
                      return _buildShimmer();
                    }

                    if (_chatController.chatData.isEmpty) {
                      return Center(child: CustomText(text: 'No chat yet'));
                    }

                    if (index < _chatController.chatData.length) {
                      final chat = _chatController.chatData[index];
                      if (chat.messageType == 'block' ||
                          chat.messageType == 'unblock') {
                        final isBlock = chat.messageType == 'block';
                        final myName =
                            Get.find<HomeController>().userName.value;

                        final senderMessage = isBlock
                            ? 'You blocked $myName'
                            : 'You unblocked  $myName';
                        final receiverMessage = isBlock
                            ? 'You have been blocked by ${receiver?.name ?? ''}'
                            : 'You have been unblocked by ${receiver?.name ?? ''}';

                        return Center(
                          child: Column(
                            children: [
                              CustomText(
                                fontsize: 7.h,
                                text: TimeFormatHelper.formatDateTime(
                                  DateTime.tryParse(chat.createdAt ?? '') ??
                                      DateTime.now(),
                                ),
                              ),
                              CustomText(
                                fontsize: 12.sp,
                                text: chat.senderId == userId
                                    ? senderMessage
                                    : receiverMessage,
                                bottom: 8,
                              ),
                            ],
                          ),
                        );
                      }
                      return ChatBubbleMessage(
                        status: receiver?.status ?? '',
                        isSeen: chat.seenList!.length > 1,
                        time: TimeFormatHelper.timeFormat(
                            DateTime.tryParse(chat.createdAt ?? '') ??
                                DateTime.now()),
                        text: chat.isDeleted == true ? chat.messageStatus ?? '' :  chat.message ?? '',
                        isMe: userId == chat.senderId,
                        deleteText: (){
                          _chatController.deleteMessage(context,chat.sId!,chat.chatId!);
                        },
                      );
                    } else {
                      return index < _chatController.totalPage
                          ? CustomLoader()
                          : SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          ),
          _buildBlockUnblockSection(receiver),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildBlockUnblockSection(Receiver? receiver) {
    return Obx(() {
      final name = receiver?.name ?? '';
      final receiverId = receiver?.id ?? '';
      final chatId = widget.chatData['chatId'] ?? '';
      if (_chatController.chatData.isNotEmpty) {
        final bool isBlocked = _chatController.chatData[0].messageType == 'block';
        final bool isBlockedByMe = _chatController.chatData[0].senderId == userId;
        if (isBlocked) {
          if (isBlockedByMe) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: CustomContainer(
                width: double.infinity,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
                child: Center(
                  child: Column(
                    children: [
                      CustomText(
                        top: 10,
                        text: "You've blocked $name",
                        color: Colors.grey,
                        fontsize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text:
                            "You can't message or call them in this chat, and you won't receive their messages.",
                        color: Colors.grey,
                        fontsize: 10.sp,
                      ),
                      CustomText(
                        onTap: () {
                          showDeleteORSuccessDialog(
                            context,
                            title: 'Unblock $name',
                            buttonLabel: 'Unblock',
                            message:
                                'Are you sure you want to unblock $name? They will be able to contact you again.',
                            onTap: () {
                              _blockUnblockController.unblockUser(
                                  receiverId, chatId!);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        top: 10,
                        text: 'Unblock $name',
                        color: Colors.red,
                        fontsize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CustomContainer(
              width: double.infinity,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  fontWeight: FontWeight.w600,
                  top: 10,
                  text: "You are blocked by this user.",
                ),
              ),
            );
          }
        }
      }

      return _buildMessageSender();
    });
  }

  Widget _buildMessageSender() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              validator: (_) {
                return null;
              },
              controller: _messageController,
              hintText: 'Write your message',
            ),
          ),
          SizedBox(width: 10.w),
          CustomContainer(
            onTap: () {
              if (_messageController.text.trim() == '') return;
              _socketChatController.sendMessage(
                  _messageController.text,
                  "${widget.chatData['receiverId']}",
                  "${widget.chatData['chatId']}");
              _messageController.clear();
            },
            verticalPadding: 8.r,
            horizontalPadding: 8.r,
            horizontalMargin: 4.r,
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 200,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _chatController.loadMore(
            widget.chatData['receiverId'], widget.chatData['chatId']);
        print("load more true");
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _socketChatController.offSocket(widget.chatData['chatId']);
    super.dispose();
  }

}
