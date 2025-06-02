import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_image_avatar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/block_unblock_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/socket_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatProfileViewScreen extends StatefulWidget {
  const ChatProfileViewScreen({super.key, required this.chatData});

  final Map<String, dynamic> chatData;

  @override
  State<ChatProfileViewScreen> createState() => _ChatProfileViewScreenState();
}

class _ChatProfileViewScreenState extends State<ChatProfileViewScreen> {
  final BlockUnblockController _blockUnblockController = Get.put(BlockUnblockController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String lastMessageType = Get.find<ChatController>().blockUnblock['lastMessageType'];
    final bool isBlocked = _blockUnblockController.isBlocked.value;
    final String blockId = Get.find<ChatController>().blockUnblock['blockId'] ?? '';
    final String userId = Get.find<HomeController>().userId.value;
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Hero(
              tag: widget.chatData['heroTag'],
              child: CustomImageAvatar(
                image: widget.chatData['image'],
                radius: 54.r,
              ),
            ),
          ),
          Center(
            child: CustomText(
              text: widget.chatData['name'],
              top: 16.h,
              fontsize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Status: ',
                  top: 6.h,
                  fontsize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
                Flexible(
                  child: CustomText(
                    text: ' ${widget.chatData['status']}',
                    top: 6.h,
                    fontsize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: widget.chatData['status'] == 'online'
                        ? Colors.green
                        : Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Divider(
            thickness: 0.2,
            color: Colors.black,
          ),
          SizedBox(height: 24.h),
          CustomText(
            text: 'Bio : ',
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            text: Get.find<HomeController>().bio.value,
            fontsize: 13.sp,
          ),
          SizedBox(height: 24.h),
          CustomText(
            text: 'Email : ',
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            text: widget.chatData['email'],
            fontsize: 13.sp,
          ),
          SizedBox(height: 44.h),

          if ((lastMessageType != 'block') || (userId == blockId))
    Obx(() {
      final String lastMessageType = Get.find<ChatController>().blockUnblock['lastMessageType'];
      final bool isBlocked = _blockUnblockController.isBlocked.value;
            return GestureDetector(
              onTap: () {
                showDeleteORSuccessDialog(
                  context,
                  title: lastMessageType == 'block' || isBlocked
                      ? 'Unblock ${widget.chatData['name']}'
                      : 'Block ${widget.chatData['name']}',
                  buttonLabel: lastMessageType == 'block' || isBlocked
                      ? 'Unblock'
                      : 'Block',
                  message: lastMessageType == 'block' || isBlocked
                      ? 'Are you sure you want to unblock ${widget.chatData['name']}? They will be able to contact you again.'
                      : 'Are you sure you want to block ${widget.chatData['name']}? They will no longer be able to contact you.',
                  onTap: () {
                    if (lastMessageType == 'block' || isBlocked) {
                      _blockUnblockController.unblockUser(widget.chatData['receiverId']!);
                    } else {
                      _blockUnblockController.blockUser(widget.chatData['receiverId']!);
                    }

                    Navigator.of(context).pop();
                  },
                );
              },
              child: CustomText(
                text: lastMessageType == 'block' || isBlocked
                    ? 'Unblock ${widget.chatData['name']}'
                    : 'Block ${widget.chatData['name']}',
                color: Colors.red,
                fontWeight: FontWeight.w800,
              ),
            );
          }),


          if ((lastMessageType == 'block' || isBlocked) && (userId != blockId))
            Center(
              child: CustomContainer(
                onTap: (){
                  //_blockUnblockController.unblockUser(widget.chatData['receiverId']!);

                },
                radiusAll: 16,
                paddingAll: 10,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      offset: Offset(4, 4),
                      blurRadius: 20),
                  BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      offset: Offset(-4, -4),
                      blurRadius: 20),
                ],
                child: CustomText(
                  text: "You are restricted by other user",
                  color: Colors.red,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
