import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:courtconnect/pregentaition/screens/group/widgets/group_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        showLeading: false,
        title: 'Community',
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(AppRoutes.createGroupScreen);
              },
              icon: const Icon(
                Icons.group_add_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        spacing: 16.h,
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
            hintText: 'Search Community...',
            contentPaddingVertical: 0,
          ),
          /*TwoButtonWidget(
              buttons: const [
                'All Group',
                'My Group',
              ],
              selectedIndex: _selectedIndex,
              onTap: (index) {
                _selectedIndex = index;
                setState(() {});
              }),*/
          Expanded(
            child: _selectedIndex == 0
                ? ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return GroupCardWidget(
                        title: 'Kingdom Youth',
                        subTitle: '150 Members',
                        detailAction: () {
                          context.pushNamed(AppRoutes.groupDetailsScreen);
                        },
                      );
                    })
                : ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return GroupCardWidget(
                        title: 'Alex James',
                        subTitle: '150 Members',
                        detailAction: () {
                          context.pushNamed(AppRoutes.groupDetailsScreen);
                        },
                      );
                    }),
          )
        ],
      ),
    );
  }
}
