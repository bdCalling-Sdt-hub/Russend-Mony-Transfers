import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_transfers/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class SignInController extends GetxController {
  RxBool isLoading = false.obs;
  SignInModel? signInModelInfo ;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> signInRepo() async {
    print("===================> object");

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
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        signInModelInfo = SignInModel.fromJson(json);


        pref.setString("email", emailController.text);
        pref.setString("id", signInModelInfo!.data!.attributes!.sId!);


        Get.toNamed(AppRoute.enterPassCode);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
