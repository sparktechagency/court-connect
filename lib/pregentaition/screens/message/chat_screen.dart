import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/widgets/chat_card.dart';
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

  final ChatController _controller = Get.put(ChatController());
  HomeController homeController = Get.find<HomeController>();


  @override
  void initState() {
    super.initState();
    _controller.listenMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getChat(widget.chatData['receiverId'], widget.chatData['chatId']);
    });
  }

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      appBar: CustomAppBar(
        titleWidget: Hero(
          tag: widget.chatData['heroTag'] ?? '',
          child: GestureDetector(
            onTap: (){
              context.pushNamed(AppRoutes.chatProfileViewScreen,
                extra: widget.chatData,
              );

            },
            child: CustomListTile(
              imageRadius: 20.r,
              image: widget.chatData['image'],
              title: widget.chatData['name'],
              subTitle: widget.chatData['status'] == 'online' ? 'online' : TimeFormatHelper.getTimeAgo(DateTime.parse(widget.chatData['lastActive'].toString() ?? '')),
              statusColor: widget.chatData['status'] == 'online' ? Colors.green : Colors.grey,

            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h),
          Expanded(
            child: Obx(
                    () {
                      if(_controller.isLoading.value){
                        return _buildShimmer();
                      }if(_controller.chatData.isEmpty){
                        Center(child: CustomText(text: 'No chat yet',));
                      }
                return ListView.builder(
                  reverse: true,
                  itemCount: _controller.chatData.length,
                  itemBuilder: (context, index) {
                    final chat = _controller.chatData[index];
                    return ChatBubbleMessage(
                      time: TimeFormatHelper.timeFormat(DateTime.now()),
                      profileImage: '',
                      text: chat.message ?? '',
                      isMe: homeController.userId.value == chat.senderId,
                    );
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
    return Padding(
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
      _controller.sendMessage(_messageController.text, "${widget.chatData['receiverId']}");
      _messageController.clear();
    });
  }



  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Shimmer.fromColors(
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
          ],
        ),
      ),
    );
  }


  String _getFormattedTime(dynamic updatedAt) {
    if (updatedAt == null) return 'Invalid date';

    try {
      DateTime date;

      if (updatedAt is DateTime) {
        date = updatedAt;
      } else if (updatedAt is int) {
        // If timestamp (milliseconds since epoch), convert to DateTime
        date = DateTime.fromMillisecondsSinceEpoch(updatedAt);
      } else if (updatedAt is String) {
        date = DateTime.tryParse(updatedAt) ?? DateTime.fromMillisecondsSinceEpoch(int.tryParse(updatedAt) ?? 0);
      } else {
        return 'Invalid date format';
      }

      if (date.year == 1970) return 'Invalid date format'; // Handle default conversion errors

      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inMinutes < 1) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} min ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
      } else if (difference.inDays == 1) {
        return "Yesterday";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
      } else {
        return DateFormat('dd/MM/yy').format(date); // e.g., 12/01/25
      }
    } catch (e) {
      return 'Invalid date format';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _controller.offSocket(widget.chatData['chatId']);
    super.dispose();
  }
}
