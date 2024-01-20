import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/user_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class PersonalInfoController extends GetxController {
  UserDetailsModel? userDetailsModelInfo;

  RxBool isLoading = false.obs;
  RxBool isLoadingEditNumber = false.obs;

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> userDetailsRepo(String token, String id) async {
    print("===================> userDetailsRepo");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi("${ApiUrl.user}/$id", header)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        userDetailsModelInfo = UserDetailsModel.fromJson(json);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  ///=================================> Edit Phone Number <===============================

  RxString countryCode = "".obs;

  TextEditingController numberController = TextEditingController();

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  Future<void> getIsisLogIn() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      sharedPreferenceHelper.accessToken =
          pref.getString("accessToken") ?? "aa";
      sharedPreferenceHelper.isLogIn = pref.getBool("isLogIn") ?? false;
      print(
          "Transaction ====================================> ${sharedPreferenceHelper.accessToken.toString()}");

      editNumberRepo(sharedPreferenceHelper.accessToken);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> editNumberRepo(String token) async {
    print("===================> editNumberRepo");

    var body = {
      "phoneNumber": "${countryCode.value}${numberController.text}",
    };
    print("===================>$body");
    Map<String, String> header = {'Authorization': "Bearer $token"};
    print("===================>$header");

    networkApiService
        .putApi(ApiUrl.user, body, header)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        userDetailsModelInfo = UserDetailsModel.fromJson(json);

        Get.back();
        Get.back();
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}