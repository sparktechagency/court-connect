import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/core/utils/app_colors.dart';
import 'package:courtconnect/core/widgets/custom_delete_or_success_dialog.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:courtconnect/pregentaition/screens/group/models/groupe_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../message/models/chat_list_data.dart';

class GroupController extends GetxController {
  RxBool isLoading = false.obs;
  RxString type = 'all'.obs;
  RxString page = ''.obs;
  RxString limit = ''.obs;
  RxString date = ''.obs;
  RxString name = ''.obs;
  RxString searchText = ''.obs;
  RxString communityId = ''.obs;
  RxBool alreadyJoined = false.obs;


  final currentPage = 1.obs;
  final totalPages = 1.obs;
  Rx<Pagination?> groupPagination = Rxn<Pagination>();

  // ScrollController to manage scrolling
  final ScrollController scrollController = ScrollController();


  final RxList<GroupData> _groupDataList = <GroupData>[].obs;
  Rx<GroupDetailsData> groupDetailsData = GroupDetailsData().obs;

  @override
  void onInit() {
    super.onInit();
    getGroup();
  }

  Future<void> getGroup({bool loadMore = false}) async {
    _groupDataList.clear();
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        ApiUrls.community(type.value, page.value, date.value, limit.value),
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        final List data = responseBody['data'];
        _groupDataList.value =
            data.map((json) => GroupData.fromJson(json)).toList();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }




  Future<void> loadMoreComments() async {
    if (groupPagination.value != null &&
        currentPage.value < (groupPagination.value!.totalPage ?? 1) &&
        !isLoading.value) {
      currentPage.value++;
      await getGroup(loadMore: true);
    }
  }

  void onScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
      // trigger load more a bit before reaching exact end
      loadMoreComments();
    }
  }



  List<GroupData> get filteredGroupList {
    final query = searchText.value;
    if (query.isEmpty) return _groupDataList;
    return _groupDataList
        .where((group) => (group.name ?? '').toLowerCase().contains(query))
        .toList();
  }





  Future<void> getGroupDetails(String? id) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        ApiUrls.communityDetails(id!, limit.value, page.value, name.value),
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        groupDetailsData.value =
            GroupDetailsData.fromJson(responseBody['data']);
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }




  Future<void> joinCommunity(BuildContext context, String? id) async {
    isLoading.value = true;

    try {
      final response =
          await ApiClient.postData(ApiUrls.joinCommunity, {"communityId": id!});

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
        Navigator.pop(context); // Remove current
        context.pushNamed(AppRoutes.postScreen,extra: {
          'id': communityId.value,
        },);

      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> leaveGroup(BuildContext context, String? id) async {
    isLoading.value = true;

    try {
      final response =
          await ApiClient.postData(ApiUrls.communityLeave, {"communityId": id!});

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        getGroup();
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }




  Future<void> removeMember(BuildContext context,String? communityId, memberId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(ApiUrls.removeMember, {
        "communityId": communityId!,
        "memberId": memberId!,
      });

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        Navigator.pop(context); // Remove current
        Navigator.pop(context); // Remove previous
        context.pushReplacementNamed(AppRoutes.groupDetailsScreen, extra: {
          'id': communityId,
        });      } else {
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
    getGroup();
  }
}
