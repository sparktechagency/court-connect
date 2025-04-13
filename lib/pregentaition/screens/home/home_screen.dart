import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_session_card.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/widgets/price_list_bottom_sheet.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.put(HomeController());

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: ListTile(
          title: CustomText(
            text: 'Hello',
            fontsize: 18.sp,
            textAlign: TextAlign.left,
          ),
          subtitle: Obx(() => CustomText(
                text: '${_controller.userName.value} ✨',
                fontsize: 10.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              )),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              )),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 14 / 4,
              ),
              items: _controller.bannerList
                  .map((item) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: _controller.isLoading.value
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              period: const Duration(milliseconds: 800),
                              child: SizedBox(
                                height: 114.h,
                                width: double.infinity,
                              ),
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 114.h,
                              imageUrl: '${ApiUrls.imageBaseUrl}${item.image}',
                            )))
                  .toList(),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Available Session',
                fontsize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PriceListBottomSheet();
                            });
                      },
                      icon: Assets.icons.menu.svg()),
                  IconButton(onPressed: () {}, icon: Assets.icons.myBook.svg()),
                ],
              ),
            ],
          ),
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
