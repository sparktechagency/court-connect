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
  final userEmail = ''.obs;
  final bio = ''.obs;

  final type = 'all'.obs;
  final price = ''.obs;
  final date = ''.obs;

  final isLoading = false.obs;
  final searchText = ''.obs;
  final charge = 0.obs;

  final bannerList = <BannerData>[].obs;
  final sessionList = <SessionData>[].obs;

  RxInt page = 1.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  var totalResult = (-1);

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
    userEmail.value = await PrefsHelper.getString(AppConstants.email);
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


  Future<void> getSession() async {

    if(page.value == 1){
      filteredSessionList.clear();
      isLoading(true);
    }
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
          ApiUrls.session(type.value, price.value, date.value,page.value));

      final responseBody = response.body;

      if (response.statusCode == 200 && responseBody['success'] == true) {

        List data = responseBody['data'] ?? [];

        totalPage = int.tryParse(responseBody['pagination']['totalPage'].toString()) ?? 0;
        currentPage = int.tryParse(responseBody['pagination']['currentPage'].toString()) ?? 0;
        totalResult = int.tryParse(responseBody['pagination']['totalItem'].toString()) ?? 0;

        final session = data.map((e) => SessionData.fromJson(e)).toList();

          filteredSessionList.addAll(session);
      } else{
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
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



  void loadMore() {
    print("==========================================total page ${totalPage} page No: ${page.value} == total result ${totalResult}");
    if (totalPage > page.value) {
      page.value += 1;
      getSession();
      print("**********************print here");
    }
    print("**********************print here**************");
  }



  void onChangeType(String newType) {
    type.value = newType;
    page.value = 1;
    getSession();
  }
}
