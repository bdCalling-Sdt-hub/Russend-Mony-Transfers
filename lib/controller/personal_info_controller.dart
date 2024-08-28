import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/user_details_model.dart';
import 'package:money_transfers/utils/app_utils.dart';

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

  Future<void> userDetailsRepo() async {

    Map<String, String> header = {
      'Authorization': "Bearer ${SharedPreferenceHelper.accessToken}"
    };

    isLoading.value = true;

    networkApiService
        .getApi("${ApiUrl.user}/${SharedPreferenceHelper.id}", header)
        .then((apiResponseModel) {
      isLoading.value = false;


      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        userDetailsModelInfo = UserDetailsModel.fromJson(json);
      } else if (apiResponseModel.statusCode == 401) {
        Utils.snackBarMessage(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
        Get.offAllNamed(AppRoute.logIn);
      } else if (apiResponseModel.statusCode == 404) {
        Utils.snackBarMessage(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
        Get.offAllNamed(AppRoute.logIn);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  ///=================================> Edit Phone Number <===============================

  RxString countryCode = "".obs;

  TextEditingController numberController = TextEditingController();

  Future<void> editNumberRepo() async {

    var body = {
      "phoneNumber": "${countryCode.value}${numberController.text}",
    };
    Map<String, String> header = {
      'Authorization': "Bearer ${SharedPreferenceHelper.accessToken}"
    };
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
