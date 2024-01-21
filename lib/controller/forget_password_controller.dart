import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_transfers/models/forget_password_otp_model.dart';
import 'package:money_transfers/utils/app_utils.dart';
import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class ForgetPasswordController extends GetxController {
  ForgetPasswordOtpModel? forgetPasswordOtpInfo;
  RxBool isLoadingEmailScreen = false.obs;
  RxBool isLoading = false.obs;


  RxBool isResend = false.obs;
  Duration duration = const Duration();
  Timer? timer;
  RxInt time = 60.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> forgetPasswordRepo() async {
    print("===================> forgetPasswordRepo");
    isLoadingEmailScreen.value = true;
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

      isLoadingEmailScreen.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        Get.toNamed(AppRoute.forgotPasswordVerify);
        duration = const Duration(seconds: 60);
        time.value = 60;
        startTime();
      } else if (apiResponseModel.statusCode == 404) {
        Utils.toastMessage("User does not exist");
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    print("===================> object");

    isLoading.value = true;

    var body = {
      "email": emailController.text,
      "otp": otpController.text,
    };
    print("===================>$body");

    Map<String, String> header = {};
    Get.toNamed(AppRoute.newPassword);

    networkApiService
        .postApi(ApiUrl.verifyOtp, body, header, isHeader: false)
        .then((apiResponseModel) {
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        forgetPasswordOtpInfo = ForgetPasswordOtpModel.fromJson(json);

        Get.toNamed(AppRoute.newPassword);
      } else if (apiResponseModel.statusCode == 400) {
        Utils.toastMessage("OTP is invalid, please try again");
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> resetPasswordRepo(String forgetPasswordToken) async {
    print("===================> object");
    isLoading.value = true;

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
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        emailController.clear();
        otpController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Get.toNamed(AppRoute.createSuccessful);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  ///=============================> Send Again   < =============================

  startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = 1;
      final seconds = duration.inSeconds - addSeconds;
      duration = Duration(seconds: seconds);
      print(duration);
      if (time.value != 0) {
        time.value = seconds;
      } else {
        isResend.value = true;
        timer?.cancel();
      }
    });
  }
}
