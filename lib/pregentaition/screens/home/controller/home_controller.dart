import 'package:courtconnect/core/utils/app_constants.dart';
import 'package:courtconnect/helpers/prefs_helper.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/comment/models/commant_data.dart';
import 'package:courtconnect/pregentaition/screens/home/models/banner_data.dart';
import 'package:courtconnect/pregentaition/screens/home/models/session_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final userName = ''.obs;
  final userImage = ''.obs;
  final userId = ''.obs;
  final bio = ''.obs;

  final type = 'all'.obs;
  final price = ''.obs;
  final date = ''.obs;

  final isLoading = false.obs;
  final searchText = ''.obs;
  final charge = 0.obs;

  final bannerList = <BannerData>[].obs;
  final sessionList = <SessionData>[].obs;

  final currentPage = 1.obs;
  final totalPages = 1.obs;
  Rx<Pagination?> sessionPagination = Rxn<Pagination>();

  // ScrollController to manage scrolling
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _getUser();
    _getBanner();
  }

  void _getUser() async {
    userName.value = await PrefsHelper.getString(AppConstants.name);
    userImage.value = await PrefsHelper.getString(AppConstants.image);
    userId.value = await PrefsHelper.getString(AppConstants.userId);
    bio.value = await PrefsHelper.getString(AppConstants.bio);
  }

  /// <==================== Get Banner Data ======================>
  Future<void> _getBanner() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(ApiUrls.getBanner);

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {
        List data = responseBody['data'] ?? [];
        bannerList.value = data.map((e) => BannerData.fromJson(e)).toList();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// <==================== get Session Data ======================>


  Future<void> getSession({bool loadMore = false}) async {
    if(!loadMore){
      filteredSessionList.clear();
      currentPage.value = 1;
    }
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
          ApiUrls.session(type.value, price.value, date.value,currentPage.value,totalPages.value));

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {

        List data = responseBody['data'] ?? [];
        sessionPagination.value = Pagination.fromJson(responseBody['pagination']);

        final session = data.map((e) => SessionData.fromJson(e)).toList();

        if(loadMore){
          filteredSessionList.addAll(session);
        }else{
          sessionList.value = session;
        }
      } else{
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreSessions() async {
    if (sessionPagination.value != null && currentPage.value < sessionPagination.value!.totalPage!) {
      currentPage.value++;
      await getSession(loadMore: true);
    }
  }

  void onScroll() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // Load more sessions when scrolled to the bottom
      if (!isLoading.value) {
        loadMoreSessions();
      }
    }
  }


  List<SessionData> get filteredSessionList {
    final query = searchText.value;
    if (query.isEmpty) return sessionList;
    return sessionList
        .where((group) => (group.name ?? '').toLowerCase().contains(query))
        .toList();
  }





  /// <==================== get Session Data ======================>

  Future<void> getCharge() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
          ApiUrls.charge);

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {

        charge.value = responseBody['data']['charge'];

    } else{
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onChangeType(String newType) {
    type.value = newType;
    getSession();
  }
}
