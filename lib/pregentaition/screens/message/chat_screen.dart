import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/helpers/time_format.dart';
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
  HomeController homeController = Get.find<HomeController>();


  @override
  void initState() {
    super.initState();
    _controller.currentChatData.value = widget.chatData;
    _controller.currentChatData.refresh();
    _socketChatController.listenActiveStatus();
    _socketChatController.listenMessage();
    _socketChatController.seenChat(_controller.chatId.value);
    _socketChatController.listenSeenStatus(_controller.chatId.value);
    _addScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getChat(_controller.receveId.value, _controller.chatId.value);
    });
  }

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      appBar: CustomAppBar(
        backAction: (){
         // _socketChatController.unseenChat(widget.chatData['chatId']);
          //_socketChatController.listenUnseenStatus(widget.chatData['chatId']);
        },
        titleWidget: Obx(
          () {
            var currentChatData = _controller.currentChatData;

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
                  image: currentChatData['image'],
                  title: currentChatData['name'],
                  subTitle: currentChatData['status'] == 'online'
                      ? 'online'
                      : TimeFormatHelper.getTimeAgo(DateTime.tryParse(currentChatData['lastActive'] ?? '') ?? DateTime.now()),
                  statusColor: currentChatData['status'] == 'online' ? Colors.green : Colors.grey,

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

                    if(_controller.isLoading.value){
                      return _buildShimmer();
                    }if(_controller.chatData.isEmpty){
                      Center(child: CustomText(text: 'No chat yet',));

                    }
                    if(index < _controller.chatData.length){
                      final chat = _controller.chatData[index];
                      var currentChatData = _controller.currentChatData;


                      return ChatBubbleMessage(
                        status: currentChatData['status'] ?? '',
                        isSeen: chat.seenList!.length > 1,
                        time: TimeFormatHelper.timeFormat(DateTime.tryParse(chat.createdAt ?? '') ?? DateTime.now()),
                        //time:formattedTime,
                        text: chat.message ?? '',
                        isMe: homeController.userId.value == chat.senderId,
                      );
                    }else{
                      return index < _controller.totalPage ? CustomLoader() : SizedBox.shrink();
                    }



                  },
                );
              }
            ),
          ),
          _buildMessageSender(),
          SizedBox(height: 10.h),
        ],
      ),
    );
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
