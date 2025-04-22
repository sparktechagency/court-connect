import 'package:courtconnect/core/app_routes/app_routes.dart';
import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/group/models/group_details_data.dart';
import 'package:courtconnect/pregentaition/screens/group/models/groupe_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class GroupController extends GetxController {
  RxBool isLoading = false.obs;
  RxString type = 'all'.obs;
  RxString page = ''.obs;
  RxString limit = ''.obs;
  RxString date = ''.obs;
  RxString name = ''.obs;

  RxList<GroupData> groupDataList = <GroupData>[].obs;
  Rx<GroupDetailsData> groupDetailsData = GroupDetailsData().obs;

  @override
  void onInit() {
    super.onInit();
    getGroup();
  }

  Future<void> getGroup() async {
    groupDataList.clear();
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        ApiUrls.community(type.value, page.value, date.value, limit.value),
      );

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        final List data = responseBody['data'];
        groupDataList.value =
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
        context.pushReplacementNamed(AppRoutes.postScreen);
      } else {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }




  Future<void> removeMember(String? communityId, memberId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.postData(ApiUrls.joinCommunity, {
        "communityId": communityId!,
        "memberId": memberId!,
      });

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      } else {
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
