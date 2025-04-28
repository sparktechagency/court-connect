import 'package:courtconnect/helpers/toast_message_helper.dart';
import 'package:courtconnect/pregentaition/screens/comment/models/commant_data.dart';
import 'package:courtconnect/services/api_client.dart';
import 'package:courtconnect/services/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  RxBool isLoading = false.obs;
  RxString postId = ''.obs;
  RxString comment = ''.obs;

  RxInt page = 1.obs;
  var totalPage = (-1);
  var currentPage = (-1);
  var totalResult = (-1);


  final ScrollController scrollController = ScrollController();
  final RxList<CommentData> commentData = <CommentData>[].obs;



  Future<void> getComment(String id, String type) async {

    try {

      if(page.value == 1){
        commentData.clear();
        isLoading(true);
      }
      var response = await ApiClient.getData(ApiUrls.getComment(id,type,"${page.value}"),);

      final responseBody = response.body;
      if (response.statusCode == 200 && responseBody['success'] == true) {
        totalPage = int.tryParse(responseBody['pagination']['totalPage'].toString()) ?? 0;
        currentPage = int.tryParse(responseBody['pagination']['currentPage'].toString()) ?? 0;
        totalResult = int.tryParse(responseBody['pagination']['totalItem'].toString()) ?? 0;
        final List data = responseBody['data'];

        final comments = data.map((json) => CommentData.fromJson(json)).toList();

          commentData.addAll(comments);
          update();
          isLoading(false);
      } else {
        isLoading(false);
        ToastMessageHelper.showToastMessage(responseBody['message'] ?? "");
      }
    } catch (e) {
      ToastMessageHelper.showToastMessage("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void loadMore(String id,type) {
    print("==========================================total page ${totalPage} page No: ${page.value} == total result ${totalResult}");
    if (totalPage > page.value) {
      page.value += 1;
      getComment(id,type);
      print("**********************print here");
      update();
    }
    print("**********************print here**************");
  }


}
