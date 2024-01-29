import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class NotificationController extends GetxController {
  NotificationModel? notificationModelInfo;

  RxList notificationList = [].obs ;


  RxBool isMoreLoading = false.obs;
  RxBool loading = false.obs;

  int page = 1;

  ScrollController scrollController = ScrollController();


  NetworkApiService networkApiService = NetworkApiService();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper() ;


  void onInit() {
    notificationRepo();
    scrollController.addListener(() {
      scrollControllerCall();
    });
    super.onInit();
  }


  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("calling");
      await notificationRepo();
    } else {
      print(" not calling");
    }
  }



  Future<void> notificationRepo() async {
    print("===================> transactionDetailsRepo");

    Map<String, String> header = {'Authorization': "Bearer ${SharedPreferenceHelper.accessToken}"};

    isMoreLoading.value = true;
    if(notificationList.isEmpty) {
      loading.value = true ;
    }

    networkApiService
        .getApi(
      "${ApiUrl.notification}?page=$page",
      header,
    )
        .then((apiResponseModel) {
      isMoreLoading.value = false;
      loading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        notificationModelInfo = NotificationModel.fromJson(json);
        for (var item
        in notificationModelInfo!.data!.attributes!.notificationList!) {
          notificationList.add(item);
        }        print(notificationList.length);
        page = page+1 ;
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
