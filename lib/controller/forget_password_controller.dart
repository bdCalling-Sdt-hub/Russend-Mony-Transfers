import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_transfers/models/forget_password_otp_model.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class ForgetPasswordController extends GetxController {
  List forgetPasswordOtpInfo = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> forgetPasswordRepo() async {
    print("===================> object");

    var body = {
      "email": emailController.text,
    };
    print("===================>$body");

    Map<String, String> header = {};

    networkApiService
        .postApi(ApiUrl.forgetPassword, body, header, isHeader: false)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        Get.toNamed(AppRoute.forgotPasswordVerify);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    print("===================> object");

    var body = {
      "email": emailController.text,
      "otp": otpController.text,
    };
    print("===================>$body");

    Map<String, String> header = {};

    networkApiService
        .postApi(ApiUrl.verifyOtp, body, header, isHeader: false)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);


        forgetPasswordOtpInfo.add(ForgetPasswordOtpModel.fromJson(json));

        Get.toNamed(AppRoute.newPassword);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> resetPasswordRepo(String forgetPasswordToken) async {
    print("===================> object");

    var body = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    print("===================>$body");

    Map<String, String> header = {
      'Forget-password': 'Forget-password $forgetPasswordToken',
    };
    networkApiService
        .postApi(ApiUrl.resetPassword, body, header)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);


        Get.toNamed(AppRoute.createSuccessful);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
