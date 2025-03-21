import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_app_bar.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_session_card.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../global/custom_assets/assets.gen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        showLeading: false,
        title: 'Available Session',
        actions: [
          IconButton(onPressed: () {}, icon: Assets.icons.myBook.svg()),
        ],
      ),
      body: Column(
        children: [
          TwoButtonWidget(
              buttons: const [
                'All Session',
                'My Session',
              ],
              selectedIndex: _selectedIndex,
              onTap: (index) {
                _selectedIndex = index;
                setState(() {});
              }),
          SizedBox(height: 16.h),
          Expanded(
            child: _selectedIndex == 0
                ? ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return CustomSessionCard(
                        title: 'Sailing Komodo',
                        subtitles: const [
                          '\$ 100',
                          'Bonosree, Dhaka, Bangladeh',
                          'Jun 20,2025 | 10:30PM',
                        ],
                        onTap: () {
                          context.pushNamed(AppRoutes.bookedNowScreen);
                        },
                        buttonLabel: 'Booked Now',
                      );
                    })
                : ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return CustomSessionCard(
                        title: 'Sailing Komodo',
                        subtitles: const [
                          '\$ 100',
                          'Bonosree, Dhaka, Bangladeh',
                          'Jun 20,2025 | 10:30PM',
                        ],
                        onTap: () {
                          context.pushNamed(AppRoutes.registeredUsersScreen);
                        },
                        buttonLabel: 'Registered Users',
                      );
                    }),
          )
        ],
      ),
    );
  }
}
