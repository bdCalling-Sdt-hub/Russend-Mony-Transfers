import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/user_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/api_url.dart';
import '../services/api_services/api_services.dart';
import '../utils/app_icons.dart';

class PersonalInfoController extends GetxController {
  UserDetailsModel? userDetailsModelInfo;

  RxBool isLoading = false.obs;
  RxBool isLoadingEditNumber = false.obs;

  List<Map<String, String>> profile = [
    {
      "icon": AppIcons.profile,
      "title": "Personal info".tr,
    },
    {"icon": AppIcons.security, "title": "Security".tr},
    {"icon": AppIcons.language, "title": "Language".tr},
    // {
    //   "icon" : AppIcons.appearance,
    //   "title" : "Appearance".tr
    // },
    {"icon": AppIcons.legal, "title": "Legal".tr}
  ];

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> userDetailsRepo(String token, String id) async {
    print("===================> userDetailsRepo");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi("${ApiUrl.user}/$id", header)
        .then((apiResponseModel) {
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
    Map<String, String> header = {'Authorization': "Bearer $token"};
    networkApiService
        .putApi(ApiUrl.user, body, header)
        .then((apiResponseModel) {
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
