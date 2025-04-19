import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/controller/book_mark_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/controller/registered_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:courtconnect/helpers/time_format.dart';
import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/widgets/custom_button.dart';
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/core/widgets/custom_session_card.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/widgets/price_list_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.put(HomeController());
  final _userController = Get.put(RegisteredUsersController());
  final _bookMarkController = Get.put(BookMarkController());
  final _searchController = TextEditingController();

  final _sessionTypes = [
    {'label': 'All Session', 'value': 'all'},
    {'label': 'My Session', 'value': 'my'},
  ];

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
                text: '${_homeController.userName.value} ✨',
                fontsize: 10.sp,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              )),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => CarouselSlider(
                options: CarouselOptions(autoPlay: true, aspectRatio: 14 / 4),
                items: _homeController.bannerList.map((item) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: _homeController.isLoading.value
                        ? _buildShimmer(height: 114.h)
                        : GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(item.link ?? '');
                              if (await launchUrl(url)) await launchUrl(url);
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height: 114.h,
                              imageUrl: '${ApiUrls.imageBaseUrl}${item.image}',
                            ),
                          ),
                  );
                }).toList(),
              )),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _searchController,
                  hintText: 'Search Session',
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => const PriceListBottomSheet(),
                    ),
                    icon: Assets.icons.menu.svg(),
                  ),
                  IconButton(
                    onPressed: () =>
                        context.pushNamed(AppRoutes.bookedNowScreen),
                    icon: Assets.icons.myBook.svg(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Obx(() => TwoButtonWidget(
                buttons: _sessionTypes,
                selectedValue: _homeController.type.value,
                onTap: _homeController.onChangeType,
              )),
          SizedBox(height: 16.h),
          Expanded(
            child: Obx(() {
              if (_homeController.isLoading.value) {
                return _buildShimmer(height: 300.h);
              }

              if (_homeController.sessionList.isEmpty) {
                return const Center(child: Text("No sessions available"));
              }

              return ListView.builder(
                itemCount: _homeController.sessionList.length,
                itemBuilder: (context, index) {
                  final session = _homeController.sessionList[index];
                  return CustomSessionCard(
                    image: '${ApiUrls.imageBaseUrl}${session.image}',
                    title: session.name ?? '',
                    subtitles: [
                      '\$ ${session.price}',
                      session.location ?? '',
                      '${TimeFormatHelper.formatDate(DateTime.parse(session.date.toString()))} | ${session.time}',
                    ],
                    onTap: () {
                      if(_homeController.type.value == 'all'){
                        _bookMarkController.getBookMark( session.sId ?? '');
                        _showBookingDialog(context);

                    }else{
                        _userController.getUser(context,session.sId ?? '');
                      }
                    },
                    buttonLabel: _homeController.type.value == 'all' ? 'Book Now' : 'Registered Users',
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildShimmer({required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 800),
      child: Container(
        height: height,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }

  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icons.bookingSuccess.svg(),
              SizedBox(height: 24.h),
              CustomText(
                text: 'Booking Successful!',
                fontWeight: FontWeight.w500,
                fontsize: 22.sp,
              ),
              SizedBox(height: 24.h),
              CustomButton(
                onPressed: () => context.pop(),
                label: 'Go Back',
                width: 160.w,
                radius: 8.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
