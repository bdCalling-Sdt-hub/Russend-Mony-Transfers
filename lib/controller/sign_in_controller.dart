import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  RxBool isSignIn = false.obs;
  SignInModel? signInModelInfo;

  TextEditingController emailController = TextEditingController(text: kDebugMode ? "testing.client@gmail.com" : "");

  TextEditingController passwordController = TextEditingController(text: kDebugMode ? "helloclient" : "");

  NetworkApiService networkApiService = NetworkApiService();

  String? validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*?[a-z]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password'.tr;
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password'.tr;
      } else {
        return null;
      }
    }
  }

  Future<void> signInRepo() async {

    isLoading.value = true;
    var body = {
      "email": emailController.text,
      "password": passwordController.text
    };
    Map<String, String> header = {};

    SharedPreferences pref = await SharedPreferences.getInstance();

    networkApiService
        .postApi(ApiUrl.signIn, body, header, isHeader: false)
        .then((apiResponseModel) {
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        isSignIn.value = true ;
        var json = jsonDecode(apiResponseModel.responseJson);
        signInModelInfo = SignInModel.fromJson(json);
        pref.setString("email", emailController.text);
        pref.setString("id", signInModelInfo!.data!.attributes!.sId!);
        SharedPreferenceHelper.id = signInModelInfo!.data!.attributes!.sId!;

        Get.toNamed(AppRoute.passCode);

        emailController.clear();
        passwordController.clear();
      } else if (apiResponseModel.statusCode == 201) {
        isSignIn.value = true ;
        var json = jsonDecode(apiResponseModel.responseJson);
        signInModelInfo = SignInModel.fromJson(json);
        pref.setString("email", emailController.text);
        pref.setString("id", signInModelInfo!.data!.attributes!.sId!);
        Get.toNamed(AppRoute.passCode);
        emailController.clear();
      } else if (apiResponseModel.statusCode == 401) {
        Utils.toastMessage("EmailOrPasswordIsIncorrectPleaseTryAgainLater".tr);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
