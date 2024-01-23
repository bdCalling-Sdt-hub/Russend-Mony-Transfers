import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';
import '../utils/app_utils.dart';

class ChangePasscodeController extends GetxController {
  RxBool disableKeyboard = false.obs;

  RxBool isLoading = false.obs;

  TextEditingController passcodeController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> changePasscodeRepo(String token) async {
    print("===================> changePasscodeRepo");
    isLoading.value = true;
    var body = {
      "email": passcodeController.text,
    };
    print("===================>$body");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    networkApiService
        .postApi(ApiUrl.verifyOldPasscode, body, header)
        .then((apiResponseModel) {
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        Get.toNamed(AppRoute.newPasscode);
      } else if (apiResponseModel.statusCode == 404) {
        Utils.toastMessage("passcode not match".tr);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
