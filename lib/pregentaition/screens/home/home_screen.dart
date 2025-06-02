import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_container.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/core/widgets/custom_loader.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/home/booked_now_screen/controller/book_mark_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/session_edit/controller/session_edit_controller.dart';
import 'package:courtconnect/pregentaition/screens/notification/controller/notification_controller.dart';
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
import 'package:courtconnect/core/widgets/custom_scaffold.dart';
import 'package:courtconnect/core/widgets/custom_text.dart';
import 'package:courtconnect/core/widgets/custom_text_field.dart';
import 'package:courtconnect/core/widgets/custom_session_card.dart';
import 'package:courtconnect/core/widgets/two_button_widget.dart';
import 'package:courtconnect/global/custom_assets/assets.gen.dart';
import 'package:courtconnect/pregentaition/screens/home/controller/home_controller.dart';
import 'package:courtconnect/pregentaition/screens/home/widgets/price_list_bottom_sheet.dart';
import 'package:badges/badges.dart' as badges;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = Get.put(HomeController());
  final _bookMarkController = Get.put(BookMarkController());
  final _sessionEditController = Get.put(SessionEditController());
  final _notificationController = Get.put(NotificationController());
  final _searchController = TextEditingController();

  final _sessionTypes = [
    {'label': 'All Sessions', 'value': 'all'},
    {'label': 'My Sessions', 'value': 'my'},
  ];


  @override
  void initState() {
    super.initState();
    _homeController.getBanner();
    _notificationController.getNotificationBadge();
    _homeController.getSession();
    _searchController.addListener(() {
      _homeController.searchText.value = _searchController.text.toLowerCase();
      _addScrollListener();
    });

  }

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
          Obx(
            () {
              return Padding(
                padding:  EdgeInsets.only(right: 16.w),
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -6, end: -2),
                  showBadge: _notificationController.unreadCount.value <= 0 ? false : true,
                  badgeContent: CustomText(text: _notificationController.unreadCount.value.toString() ,color: Colors.black,fontWeight: FontWeight.w600,fontsize: 8.sp,),
                  child: GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.notificationScreen);
                    },
                    child:  Icon(Icons.notifications, color: Colors.black,size: 28.r,),
                  ),
                ),
              );
            }
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (_homeController.bannerList.isEmpty) {
              return const SizedBox();
            }

            return CarouselSlider(
              options: CarouselOptions(
                viewportFraction: .7,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 14 / 4,
              ),
              items: _homeController.bannerList.map((item) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(item.link ?? '');
                      if (await launchUrl(url)) {
                        await launchUrl(url);
                      }
                    },
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 114.h,
                      imageUrl: '${ApiUrls.imageBaseUrl}${item.image}',
                    ),
                  ),
                );
              }).toList(),
            );
          }),

          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  validator: (_) => null,
                  controller: _searchController,
                  hintText: 'Search Sessions',
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
            child: RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: ()async{
                await _homeController.getSession();
              },
              child: Obx(() {
                if (_homeController.isLoading.value && _homeController.filteredSessionList.isEmpty) {
                  return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => _buildShimmer(height: 280.h),
                  );
                }

                if (_homeController.filteredSessionList.isEmpty) {
                  return const Center(child: Text("No sessions available"));
                }

                return ListView.builder(
                  controller: _homeController.scrollController,
                  itemCount: _homeController.filteredSessionList.length + 1,
                  itemBuilder: (context, index) {
                    if(index == _homeController.filteredSessionList.length){
                      return _homeController.isLoading.value ? Center(child: CustomLoader(),) : SizedBox();
                    }
                    if(index < _homeController.filteredSessionList.length){
                      final session = _homeController.filteredSessionList[index];
                      return Obx(
                              () {
                            return CustomSessionCard(
                              menuItems:  _homeController.type.value == 'all' ? []: [
                                'Edit',
                                'Delete'
                              ],
                              onSelected: (val){
                                if(val == 'Edit'){
                                  context.pushNamed(
                                    AppRoutes.editSessionScreen,  // Name of the route
                                    extra: {
                                      'id' : session.sId,
                                      'name': session.name,
                                      'image': '${ApiUrls.imageBaseUrl}${session.image}',
                                      'price': session.price,
                                      'location': session.location,
                                      'date': session.date,
                                      'time': session.time,
                                    },
                                  );
                                }else if(val == 'Delete'){
                                  showDeleteORSuccessDialog(context, onTap: () {
                                    context.pop();
                                    _sessionEditController.deleteMySession(session.sId!);
                                  });
                                }

                              },
                              image: '${ApiUrls.imageBaseUrl}${session.image}',
                              title: session.name ?? '',
                              subtitles: [
                                '\$ ${session.price}',
                                session.location ?? '',
                                '${TimeFormatHelper.formatDate(DateTime.parse(session.date.toString()))} | ${session.time}',
                              ],
                              onTap: () {
                                if(  session.isbooked == true || _bookMarkController.isBookedMap[session.sId] == true){
                                  ToastMessageHelper.showToastMessage("It's Already Booked");

                                }else if(_homeController.type.value == 'all'){
                                  _bookMarkController.getBookMark( context,session.sId ?? '');
                                }
                                else{
                                  context.pushNamed(AppRoutes.registeredUsersScreen,pathParameters: {'sessionId': session.sId!});
                                }
                              },
                              buttonLabel: _bookMarkController.isLoadingMap[session.sId] == true
                                  ? 'Please wait..'
                                  :(_bookMarkController.isBookedMap[session.sId] == true || session.isbooked == true)
                                  ? 'Booked'
                                  : _homeController.type.value == 'all'
                                  ? 'Book Now'
                                  : 'Registered Users',


                            );
                          }
                      );

                    }else{
                      return index < _homeController.totalPage ? CustomLoader() : SizedBox.shrink();

                    }
                  },
                );
              }),
            ),
          )
        ],
      ),
    );
  }


  void _addScrollListener() {
    _homeController.scrollController.addListener(() {
      if (_homeController.scrollController.position.pixels ==
          _homeController.scrollController.position.maxScrollExtent) {
        _homeController.loadMore();
        print("load more true");
      }
    });
  }


  Widget _buildShimmer({required double height}) {
    return Padding(
      padding:  EdgeInsets.all(8.0.r),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        period: const Duration(milliseconds: 800),
        child: CustomContainer(
          radiusAll: 8.r,
          height: height,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }

}
