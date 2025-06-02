import 'dart:ui';

import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChatBubbleMessage extends StatelessWidget {
  final String time;
  final String? text;
  final String? image;
  final bool isSeen;
  final bool isMe;
  final String status;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    this.text,
    this.image,
    required this.isMe,
    this.isSeen = false,
    this.status = 'offline',
  });

  @override
  Widget build(BuildContext context) {
    void onLongPressStart(
        LongPressStartDetails details, message, VoidCallback deleteText) {
      showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: MyMessageEdit(
              message: message,
              deleteText: deleteText,
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: GestureDetector(
                  onLongPressStart: (details){
                    onLongPressStart(details,text,(){});
                  },
                  child: CustomContainer(
                    horizontalPadding: 16.w,
                    verticalPadding: 8.h,
                    color:
                        isMe ? AppColors.primaryColor : const Color(0xffEEEEEE),
                    radiusAll: 10.r,
                    child: _buildMessageContent(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              CustomText(
                fontsize: 8,
                fontWeight: FontWeight.w400,
                text: time,
                left: isMe ? 0 : 24.w,
                right: isMe ? 24.w : 0,
                color: Colors.grey,
              ),
              _buildMessageStatusIcon(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
    if (text?.isNotEmpty == true) {
      return CustomText(
        maxline: 10,
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w400,
        color: isMe ? Colors.white : Colors.black,
        text: text!,
      );
    } else if (image?.isNotEmpty == true) {
      return BubbleNormalImage(
        id: 'id001',
        image: Image.network(image!),
        color: AppColors.primaryColor,
        tail: true,
      );
    }
    return const SizedBox(); // If neither text nor image, return empty
  }

  Widget _buildMessageStatusIcon() {
    if (!isMe) return const SizedBox(); // No status icon for received messages

    if (isSeen) {
      return Icon(Icons.done_all, size: 10.r, color: Colors.green); // Seen
    } else if (status == 'online') {
      return Icon(Icons.done_all, size: 10.r, color: Colors.grey); // Delivered
    } else {
      return Icon(Icons.check, size: 10.r, color: Colors.grey); // Sent
    }
  }
}

class MyMessageEdit extends StatelessWidget {
  const MyMessageEdit(
      {super.key, required this.message, required this.deleteText});

  final String message;
  final VoidCallback deleteText;

  @override
  Widget build(BuildContext context) {
    final double screenSize = MediaQuery.sizeOf(context).height;
    return screenSize < 500
        ? SingleChildScrollView(
            child: _buildEditSection(screenSize, context),
          )
        : _buildEditSection(screenSize, context);
  }

  Widget _buildEditSection(double screenSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 8),
          Container(
            constraints: BoxConstraints(
                maxHeight:
                    screenSize > 700 ? screenSize * 0.5 : screenSize * 0.4),
            child: SingleChildScrollView(
              child: ChatBubbleMessage(
                text: message,
                isMe: true,
                time: '',
              ),
            ),
          ),
          CustomContainer(
            width: 250.w,
            radiusAll: 12.r,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message)).then((_) {
                      ToastMessageHelper.showToastMessage(
                          'Copied to clipboard');
                    });
                    context.pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Copy',
                        fontName: '',
                      ),
                      Icon(CupertinoIcons.doc_on_doc, color: Colors.black),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.3,
                ),
                CupertinoButton(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  onPressed: deleteText,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Delete message',
                        color: Colors.red,
                        fontName: '',
                      ),
                      Icon(CupertinoIcons.delete, color: Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
