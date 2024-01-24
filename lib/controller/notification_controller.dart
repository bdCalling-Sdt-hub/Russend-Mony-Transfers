import 'dart:convert';

import 'package:get/get.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class NotificationController extends GetxController {
  NotificationModel? notificationModelInfo;

  RxBool isLoading = false.obs;

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> getIsisLogIn() async {
    try {
      SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
      SharedPreferences pref = await SharedPreferences.getInstance();

      sharedPreferenceHelper.accessToken = pref.getString("accessToken") ?? "";
      sharedPreferenceHelper.isLogIn = pref.getBool("isLogIn") ?? false;
      notificationRepo(sharedPreferenceHelper.accessToken);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> notificationRepo(String token) async {
    print("===================> transactionDetailsRepo");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi(
      ApiUrl.notification,
      header,
    )
        .then((apiResponseModel) {
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        notificationModelInfo = NotificationModel.fromJson(json);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
