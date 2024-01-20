



import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class EditNumberController extends GetxController {


  RxString countryCode = "".obs ;
  RxBool isLoading = false.obs;
  TextEditingController numberController = TextEditingController() ;

  NetworkApiService networkApiService = NetworkApiService();


  // Future<void> editNumberRepo(String token) async {
  //   print("===================> object");
  //
  //   var body = {
  //     "phoneNumber": "${countryCode.value}${numberController.text}",
  //   };
  //   print("===================>$body");
  //   Map<String, String> header = {'Authorization': "Bearer $token"};
  //   print("===================>$header");
  //
  //
  //
  //   networkApiService
  //       .putApi(ApiUrl.signIn, body, header)
  //       .then((apiResponseModel) {
  //     print(apiResponseModel.statusCode);
  //     print(apiResponseModel.message);
  //     print(apiResponseModel.responseJson);
  //
  //     if (apiResponseModel.statusCode == 200) {
  //       var json = jsonDecode(apiResponseModel.responseJson);
  //
  //       signInInfo.add(SignInModel.fromJson(json));
  //
  //       SignInModel signInModel = signInInfo[0];
  //
  //
  //     } else {
  //       Get.snackbar(
  //           apiResponseModel.statusCode.toString(), apiResponseModel.message);
  //     }
  //   });
  // }




}