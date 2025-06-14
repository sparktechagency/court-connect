import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/chat_controller.dart';
import 'package:courtconnect/pregentaition/screens/message/controller/socket_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatController _controller = Get.put(ChatController());
  final SocketChatController _socketChatController = Get.put(SocketChatController());

  @override
  void initState() {
    _socketChatController.listenActiveStatus();
    _socketChatController.listenMessage();
    _controller.getChatList();
    _controller.searchText.value = _searchController.text.toLowerCase();
    _addScrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: const CustomAppBar(
          title: 'Chats',
          showLeading: false,
        ),
        body: Column(
          children: [
            CustomTextField(
              onChanged: (val) {
                _controller.searchText.value = val.toLowerCase();
              },
              validator: (_) {
                return null;
              },
              borderRadio: 90.r,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: const Icon(Icons.search),
              ),
              controller: _searchController,
              hintText: 'Search people to chat...',
              contentPaddingVertical: 0,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async {
                  await _controller.getChatList();
                },
                child: Obx(() {
                  if (_controller.isChatListDataLoading.value) {
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => _buildSimmer(),
                    );
                  }

                  if (_controller.filteredChatList.isEmpty) {
                    return const Center(child: Text("No chat available"));
                  }

                  return ListView.builder(
                      itemCount: _controller.filteredChatList.length,
                      itemBuilder: (context, index) {
                        final chatData = _controller.filteredChatList[index];
                        if (index < _controller.filteredChatList.length) {
                          return Hero(
                            tag: index,
                            child: CustomListTile(
                              onTap: () {
                                context.pushNamed(AppRoutes.chatScreen, extra: {
                                  'receiverId': chatData.receiver?.id ?? '',
                                  'chatId': chatData.chatId ?? '',
                                  'index': index,
                                });
                              },
                              selectedColor: (chatData.unreadCount ?? 0) > 0
                                  ? AppColors.primaryColor.withOpacity(0.8)
                                  : null,
                              image: chatData.receiver?.image ?? '',
                              title: chatData.receiver?.isDeleted ?? false ? 'Court-connect User' :  chatData.receiver?.name ?? '',
                              activeColor: chatData.receiver?.status == 'online'
                                  ? Colors.green
                                  : Colors.grey,
                              subTitle: chatData.lastMessage?.message ?? '',
                              trailing: (chatData.unreadCount ?? 0) > 0
                                  ? CustomContainer(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                      child: Padding(
                                        padding: EdgeInsets.all(6.r),
                                        child: CustomText(
                                            text: chatData.unreadCount
                                                    .toString(),
                                            color: Colors.white,
                                            fontsize: 10.sp),
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        } else {
                          return index < _controller.chatListTotalPage
                              ? CustomLoader()
                              : SizedBox.shrink();
                        }
                      });
                }),
              ),
            ),
          ],
        ));
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _controller.loadMoreChatList();
        print("load more true");
      }
    });
  }

  Widget _buildSimmer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Circle
            Container(
              width: 40.w,
              height: 40.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),

            // Comment Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Placeholder
                  Container(
                    height: 12.h,
                    width: 100.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),
                  // Comment Line 1
                  Container(
                    height: 10.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 6.h),
                  // Comment Line 2
                  Container(
                    height: 10.h,
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
