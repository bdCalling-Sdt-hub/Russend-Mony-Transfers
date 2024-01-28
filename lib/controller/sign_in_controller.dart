import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/sign_in_model.dart';
import 'package:money_transfers/utils/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;
  SignInModel? signInModelInfo;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> signInRepo() async {
    print("===================> object");

    isLoading.value = true;
    var body = {
      "email": emailController.text,
      "password": passwordController.text
    };
    print("===================>$body");
    Map<String, String> header = {};

    SharedPreferences pref = await SharedPreferences.getInstance();

    networkApiService
        .postApi(ApiUrl.signIn, body, header, isHeader: false)
        .then((apiResponseModel) {
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        signInModelInfo = SignInModel.fromJson(json);
        pref.setString("email", emailController.text);
        pref.setString("id", signInModelInfo!.data!.attributes!.sId!);
        Get.toNamed(AppRoute.enterPassCode);
        emailController.clear();
      } else if (apiResponseModel.statusCode == 201) {
        var json = jsonDecode(apiResponseModel.responseJson);
        signInModelInfo = SignInModel.fromJson(json);
        pref.setString("email", emailController.text);
        pref.setString("id", signInModelInfo!.data!.attributes!.sId!);
        Get.toNamed(AppRoute.enterPassCode);
        emailController.clear();
      } else if (apiResponseModel.statusCode == 401) {
        var data = jsonDecode(apiResponseModel.responseJson);

        Utils.toastMessage(data['message'] ??
            "Email or password is incorrect, please try again later".tr);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
