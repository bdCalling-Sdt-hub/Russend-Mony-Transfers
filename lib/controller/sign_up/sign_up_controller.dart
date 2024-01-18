import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_transfers/models/sign_up_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_route/app_route.dart';
import '../../global/api_url.dart';
import '../../services/api_services/api_services.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxList signUpInfo = [].obs;



  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();


  Future<void> signUpRepo() async {
    print("===================> object");

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
      if (apiResponseModel.statusCode == 200) {
        print(apiResponseModel.statusCode);
        print(apiResponseModel.message);
        print(apiResponseModel.responseJson);
        Get.toNamed(AppRoute.signUpOtp);
      } else if (apiResponseModel.statusCode == 201) {
        print(apiResponseModel.statusCode);
        print(apiResponseModel.message);
        print(apiResponseModel.responseJson);
        Get.toNamed(AppRoute.signUpOtp);
      }
    });
  }

  Future<void> signUpAuthRepo() async {
    print("===================> object");

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
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      if (apiResponseModel.statusCode == 200) {


        var json = jsonDecode(apiResponseModel.responseJson);

        print("===========================> ${json.runtimeType}");
        signUpInfo.add(SignUpModel.fromJson(json)) ;
        Get.toNamed(AppRoute.passCode);

      } else if (apiResponseModel.statusCode == 201) {

        var json = jsonDecode(apiResponseModel.responseJson);

        print("===========================> ${json.runtimeType}");

        signUpInfo.add(SignUpModel.fromJson(json)) ;





        Get.toNamed(AppRoute.passCode);




      } else if (apiResponseModel.statusCode == 400) {
        Get.snackbar("Error", "OTP is invalid");
      }

    });
  }
}
