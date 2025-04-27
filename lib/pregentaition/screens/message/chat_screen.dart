import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/message/widgets/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatData});


  final Map<String,dynamic> chatData;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': "Hello! 👋", 'isSentByMe': false, 'timestamp': "10:30 AM"},
    {'text': "Hey! How are you?", 'isSentByMe': true, 'timestamp': "10:31 AM"},
    {
      'text': "I'm good, thanks! What about you?",
      'isSentByMe': false,
      'timestamp': "10:32 AM",
    },
    {
      'text': "I'm doing well too! 😊",
      'isSentByMe': true,
      'timestamp': "10:33 AM",
    },
  ];

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

            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8.h),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubbleMessage(
                  time: _messages[index]['timestamp'],
                  profileImage: '',
                  text: _messages[index]['text'],
                  isMe: _messages[index]['isSentByMe'],
                );
              },
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
    String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isSentByMe': true,
        'timestamp': formattedTime,
      });
      _messageController.clear();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
