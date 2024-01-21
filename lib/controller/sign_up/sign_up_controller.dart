import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_transfers/models/sign_up_model.dart';
import 'package:money_transfers/utils/app_utils.dart';
import '../../core/app_route/app_route.dart';
import '../../global/api_url.dart';
import '../../services/api_services/api_services.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingSignUpScreen = false.obs;
  RxList signUpInfo = [].obs;

  RxBool isResend= false.obs ;
  Duration duration = const Duration();
  Timer? timer;
  RxInt time = 60.obs;

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> signUpRepo() async {
    print("===================> signUpRepo");

    isLoadingSignUpScreen.value = true;

    var body = {
      "fullName": nameController.text,
      "email": emailController.text,
      "phoneNumber": numberController.text,
      "password": passwordController.text
    };
    print("===================>$body");
    Map<String, String> header = {
      'Otp': 'OTP ',
    };




    networkApiService
        .postApi(ApiUrl.signUp, body, header)
        .then((apiResponseModel) {
      isLoadingSignUpScreen.value = false;
      if (apiResponseModel.statusCode == 200) {
        Get.toNamed(AppRoute.signUpOtp);
        duration = const Duration(seconds: 60);
        time.value = 60;
        startTime();
      } else if (apiResponseModel.statusCode == 201) {
        Get.toNamed(AppRoute.signUpOtp);
        duration = const Duration(seconds: 60);
        time.value = 60;
        startTime();

      } else {
        Utils.snackBarMessage(apiResponseModel.statusCode.toString(), apiResponseModel.message) ;
      }
    });
  }



  Future<void> signUpAuthRepo() async {
    print("===================> signUpAuthRepo");

    isLoading.value = true;


      var body = {
        "fullName": nameController.text,
        "email": emailController.text,
        "phoneNumber": numberController.text,
        "password": passwordController.text
      };
      print("===================>$body");
      Map<String, String> header = {
        'Otp': 'OTP ${otpController.text}',
      };


    networkApiService
          .postApi(ApiUrl.signUp, body, header)
          .then((apiResponseModel) {

        isLoading.value = false;


        if (apiResponseModel.statusCode == 200) {

          var json = jsonDecode(apiResponseModel.responseJson);
          signUpInfo.add(SignUpModel.fromJson(json));
          Get.toNamed(AppRoute.passCode);
          nameController.clear() ;
          emailController.clear() ;
          numberController.clear() ;
          passwordController.clear() ;
          confirmPasswordController.clear() ;

        } else if (apiResponseModel.statusCode == 201) {

          var json = jsonDecode(apiResponseModel.responseJson);
          signUpInfo.add(SignUpModel.fromJson(json));
          Get.toNamed(AppRoute.passCode);
          nameController.clear() ;
          emailController.clear() ;
          numberController.clear() ;
          passwordController.clear() ;
          confirmPasswordController.clear() ;

        } else if (apiResponseModel.statusCode == 401) {
          Utils.snackBarMessage("Error", "OTP is invalid") ;
        } else if (apiResponseModel.statusCode == 400) {
          Utils.snackBarMessage("Error", "OTP is invalid") ;
        } else {
          Utils.snackBarMessage(apiResponseModel.statusCode.toString(), apiResponseModel.message) ;

        }
      });
    }


  ///=============================> Send Again   < =============================

  startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = 1;
      final seconds = duration.inSeconds - addSeconds;
      duration = Duration(seconds: seconds);
      if (time.value != 0) {
        time.value = seconds;
      } else {
        isResend.value = true;
        timer?.cancel();
      }
    });
  }
}







