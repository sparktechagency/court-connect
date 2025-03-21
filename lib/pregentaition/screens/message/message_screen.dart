import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_list_tile.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  final TextEditingController _searchController = TextEditingController();
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
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final bool selectedIndex = index == 0;
                    return CustomListTile(
                      onTap: (){
                        context.pushNamed(AppRoutes.chatScreen);
                      },
                      selectedColor: selectedIndex
                          ? AppColors.primaryColor.withOpacity(0.8)
                          : null,
                      image: '',
                      title: 'Maxwell Bennett',
                      subTitle: 'Hello, are you here?',
                      trailing: selectedIndex
                          ? CustomContainer(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              child: Padding(
                                padding: EdgeInsets.all(6.r),
                                child: CustomText(
                                    text: '2', color: Colors.white, fontsize: 10.sp),
                              ),
                            )
                          : null,
                    );
                  }),
            ),
          ],
        ));
  }
}
