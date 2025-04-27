import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ChatBubbleMessage extends StatelessWidget {
  final String time;
  final String? text;
  final String? audio;
  final String? image;
  final String? profileImage;
  final bool? seen;
  final bool isMe;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    this.text = '',
    this.image = '',
    required this.isMe,
    this.audio = '',
    this.profileImage = '',
    this.seen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,

            children: [
              //if (!isMe) CustomImageAvatar(right: 6.w, radius: 6.r),
              CustomContainer(
                horizontalPadding: 16.w,
                verticalPadding: 8.h,
                color:
                isMe
                    ? AppColors.primaryColor
                    : const Color(0xffEEEEEE),
                radiusAll: 10.r,
                child:
                text != ''
                    ? CustomText(
                  maxline: 10,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w400,
                  color: isMe ? Colors.white : Colors.black,
                  text: text!,
                )
                    : image != ''
                    ? BubbleNormalImage(
                  id: 'id001',
                  image: Image.network(image!),
                  color: AppColors.primaryColor,
                  tail: true,
                  seen: seen ?? false,
                )
                    : BubbleNormalAudio(
                  color: Colors.blueAccent,
                  duration: 120,
                  isPlaying: false,
                  seen: seen ?? false,
                  onPlayPauseButtonClick: () {},
                  onSeekChanged: (double value) {},
                ),
              ),
              //if (isMe) CustomImageAvatar(left: 6.w, radius: 6.r),
            ],
          ),
          const SizedBox(height: 4),
          CustomText(
            fontsize: 8,
            fontWeight: FontWeight.w400,
            text: time,
            left: isMe ? 0 : 24.w,
            right: isMe ? 24.w : 0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
