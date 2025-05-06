import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/block_unblock_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/socket_chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/widgets/chat_card.dart';
import 'package:courtconnect/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../home/controller/home_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatData});


  final Map<String,dynamic> chatData;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final ChatController _controller = Get.put(ChatController());
  final SocketChatController _socketChatController = Get.put(SocketChatController());
  final BlockUnblockController _blockUnblockController = Get.put(BlockUnblockController());
  HomeController homeController = Get.find<HomeController>();


  @override
  void initState() {
    super.initState();
    _controller.currentChatData.value = widget.chatData;
    _controller.blockUnblock.value = widget.chatData;
    _controller.currentChatData.refresh();
    _controller.blockUnblock.refresh();
    _socketChatController.listenActiveStatus();
    _socketChatController.listenMessage();
    _socketChatController.seenChat(widget.chatData['chatId'] ?? '');
    _socketChatController.listenSeenStatus(widget.chatData['chatId'] ?? '');
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getChat(widget.chatData['receiverId'] ?? '', widget.chatData['chatId'] ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {





    return CustomScaffold(
      appBar: CustomAppBar(
        titleWidget: Obx(
          () {
            var currentChatData = _controller.currentChatData;
            bool blockActive = currentChatData['lastMessageType'] != 'block' && currentChatData['status'] == 'online';

            return Hero(
              tag: currentChatData['heroTag'] ?? '',
              child: GestureDetector(
                onTap: (){
                  context.pushNamed(AppRoutes.chatProfileViewScreen,
                    extra: widget.chatData,
                  );

                },
                child: CustomListTile(
                  imageRadius: 20.r,
                  image: currentChatData['image'] ?? '',
                  title: currentChatData['name'] ?? '',
                  subTitle: blockActive
                      ? 'online'
                      : TimeFormatHelper.getTimeAgo(DateTime.tryParse(currentChatData['lastActive'] ?? '') ?? DateTime.now()),
                  statusColor: blockActive ? Colors.green : Colors.grey,

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
                  itemCount: _controller.chatData.length,
                  itemBuilder: (context, index) {

                    if (_controller.isLoading.value) {
                      return _buildShimmer();
                    }

                    if (_controller.chatData.isEmpty) {
                      return Center(child: CustomText(text: 'No chat yet'));
                    }

                    if (index < _controller.chatData.length) {
                      final chat = _controller.chatData[index];
                      var currentChatData = _controller.currentChatData;

                      // Check if the message is 'block' or 'unblock'
                      if (chat.messageType == 'block' || chat.messageType == 'unblock') {
                        final isBlock = chat.messageType == 'block';
                        final currentUserId = Get.find<HomeController>().userId.value;
                        final myName = Get.find<HomeController>().userName.value;


                        final senderMessage = isBlock
                            ? 'You blocked $myName'
                            : 'You unblocked $myName';
                        final receiverMessage = isBlock
                            ? 'You have been blocked by ${currentChatData['name'] ?? ''}'
                            : 'You have been unblocked by ${currentChatData['name'] ?? ''}';

                        return Center(
                          child: Column(
                            children: [
                              CustomText(
                                fontsize: 7.h,
                                text: TimeFormatHelper.formatDateTime(
                                  DateTime.tryParse(chat.createdAt ?? '') ?? DateTime.now(),
                                ),
                              ),
                              CustomText(
                                fontsize: 12.sp,
                                text: chat.senderId ==  currentUserId ? senderMessage : receiverMessage,
                                bottom: 8,
                              ),
                            ],
                          ),
                        );
                      }



                      // Regular message chat bubble
                      return ChatBubbleMessage(
                        status: currentChatData['status'] ?? '',
                        isSeen: chat.seenList!.length > 1,
                        time: TimeFormatHelper.timeFormat(
                            DateTime.tryParse(chat.createdAt ?? '') ?? DateTime.now()
                        ),
                        text: chat.message ?? '',
                        isMe: homeController.userId.value == chat.senderId,
                      );
                    } else {
                      return index < _controller.totalPage ? CustomLoader() : SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          ),

          _buildBlockUnblockSection(context),


          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildBlockUnblockSection(BuildContext context) {
    return Obx(() {
      final blockInfo = _controller.blockUnblock;
      final isBlocked = blockInfo['lastMessageType'] == 'block';
      final isBlockedByMe = blockInfo['blockId'] == homeController.userId.value;
      final name = widget.chatData['name'];
      final receiverId = widget.chatData['receiverId'];

      if (isBlocked) {
        if (isBlockedByMe) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: GestureDetector(
              onTap: () {
                showDeleteORSuccessDialog(
                  context,
                  title: 'Unblock $name',
                  buttonLabel: 'Unblock',
                  message: 'Are you sure you want to unblock $name? They will be able to contact you again.',
                  onTap: () {
                    _blockUnblockController.unblockUser(receiverId!);
                    Navigator.of(context).pop();
                  },
                );
              },
              child: CustomContainer(
                width: double.infinity,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                child: Center(
                  child: Column(
                    children: [

                      CustomText(
                        top: 10,
                        text:
                         "You've blocked $name ",
                          color: Colors.grey,
                          fontsize: 10.sp,
                          fontWeight: FontWeight.w700,
                      ),
                      CustomText(text:
                         "You can't message or call them in this chat, and you won't receive their messages",
                          color: Colors.grey,
                          fontsize: 10.sp,
                      ),


                      CustomText(
                        top: 10,
                        text:
                        'Unblock $name',
                          color: Colors.red,
                          fontsize: 16.sp,
                          fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
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
                  text: "You are blocked by this user."),
            ),
          );
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
            onTap: _sendMessage,
            verticalPadding: 8.r,
            horizontalPadding: 8.r,
            horizontalMargin: 4.r,
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
            child: const Icon(Icons.arrow_forward_rounded,color: Colors.white,),
          ),
        ],
      ),
    );
  }



  void _sendMessage() {
    if(_messageController.text.trim() == '') return;
    setState(() {
      _socketChatController.sendMessage(_messageController.text, "${widget.chatData['receiverId']}");
      _messageController.clear();
    });
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
        _controller.loadMore(widget.chatData['receiverId'], widget.chatData['chatId']);
        print("load more true");
      }
    });
  }



  @override
  void dispose() {
    _messageController.dispose();
    _socketChatController.offSocket(widget.chatData['chatId']);
    super.dispose();
  }
}
