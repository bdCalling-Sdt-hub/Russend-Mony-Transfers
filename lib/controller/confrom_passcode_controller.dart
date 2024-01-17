import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../models/create_passcode_model.dart';
import '../services/api_services/api_services.dart';

class ConformPasscodeController extends GetxController {


  RxList createPasscodeInfo =[].obs ;

  TextEditingController passcodeController = TextEditingController() ;



  NetworkApiService networkApiService = NetworkApiService();

  Future<void> createPasscodeRepo(String passcodeToken, String clientId, String passcode ) async {
    print("===================> object");

    var body = {
      "passcode":passcodeController.text,
      "clientId":clientId
    };
    print("===================>$body");
    Map<String, String> header = {
      'Pass-code': 'Pass-code $passcodeToken',
    };

    networkApiService
        .postApi(ApiUrl.createPasscode, body, header)
        .then((apiResponseModel) {
      if (apiResponseModel.statusCode == 200) {
        print(apiResponseModel.statusCode);
        print(apiResponseModel.message);
        print(apiResponseModel.responseJson);

        var json = jsonDecode(apiResponseModel.responseJson);

        print("===========================> ${json.runtimeType}");


        createPasscodeInfo.add(CreatePasscodeModel.fromJson(json)) ;

        print(createPasscodeInfo[0].status) ;
        Get.toNamed(AppRoute.logIn);

      }  else if (apiResponseModel.statusCode == 400) {
        Get.snackbar("Error", "Some Thing is Wrong");
      }

    });
  }




}
