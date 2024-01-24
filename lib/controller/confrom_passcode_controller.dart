import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../models/create_passcode_model.dart';
import '../services/api_services/api_services.dart';

class ConformPasscodeController extends GetxController {
  RxBool disableKeyboard = false.obs;

  CreatePasscodeModel? createPasscodeInfo;

  TextEditingController passcodeController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> createPasscodeRepo(
      String passcodeToken, String clientId, String passcode) async {
    print("===================> object");

    var body = {"passcode": passcodeController.text, "clientId": clientId};
    print("===================>$body");
    Map<String, String> header = {
      'Pass-code': 'Pass-code $passcodeToken',
    };

    networkApiService
        .postApi(ApiUrl.createPasscode, body, header)
        .then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        createPasscodeInfo = CreatePasscodeModel.fromJson(json);

        Get.toNamed(AppRoute.logIn);
      } else {
        Get.toNamed(AppRoute.createAccount);
        Get.snackbar("Error", "Some Thing is Wrong");
      }
    });
  }
}
