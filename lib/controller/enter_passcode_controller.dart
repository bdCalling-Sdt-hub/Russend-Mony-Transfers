import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_transfers/models/enter_passcode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class EnterPasscodeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLogIn = false.obs;
  RxList enterPasscodeInfo = [].obs;
  String accessToken = "" ;

  TextEditingController enterController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> enterPasscodeRepo(String passcodeToken) async {
    print("===================> enterPasscodeRepo");

    var body = {
      "passcode": enterController.text,
    };
    print("===================>$body");
    Map<String, String> header = {
      'Pass-code': 'Pass-code $passcodeToken',
    };

    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();

    networkApiService
        .postApi(ApiUrl.verifyPasscode, body, header)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        enterPasscodeInfo.add(EnterPasscodeModel.fromJson(json));

        EnterPasscodeModel enterPasscodeModel = enterPasscodeInfo[0];

        pref.setString("accessToken", enterPasscodeModel.data!.accessToken!);
        pref.setString("refreshToken", enterPasscodeModel.data!.refreshToken!);
        pref.setBool("isLogIn", true);


        accessToken = enterPasscodeModel.data!.accessToken! ;
        print("====================================> ${accessToken}") ;
        Get.toNamed(AppRoute.welcomeScreen);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }



  Future<void> signInWithPasscodeRepo(String email) async {
    print("===================> signInWithPasscodeRepo");

    var body = {
      "email": email,
      "passcode": enterController.text,
    };
    print("===================>$body");
    Map<String, String> header = {
    };

    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();

    networkApiService
        .postApi(ApiUrl.signInWithPasscode, body, header, isHeader: false)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        enterPasscodeInfo.add(EnterPasscodeModel.fromJson(json));

        EnterPasscodeModel enterPasscodeModel = enterPasscodeInfo[0];

        pref.setString("accessToken", enterPasscodeModel.data!.accessToken!);
        pref.setBool("isLogIn", true);

        accessToken = enterPasscodeModel.data!.accessToken! ;
        print("====================================> ${accessToken}") ;

        Get.toNamed(AppRoute.welcomeScreen);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
