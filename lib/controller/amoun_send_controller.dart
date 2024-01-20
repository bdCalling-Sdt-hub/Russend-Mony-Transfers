import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../global/api_url.dart';
import '../models/hidden_fee_model.dart';
import '../services/api_services/api_services.dart';

class AmountSendController extends GetxController {
  RxInt amount = 0.obs;
  RxDouble xafRate = 0.0.obs;
  RxDouble rubRate = 0.0.obs;
  RxBool success = false.obs;
  HiddenFeesModel? hiddenFeesModelInfo;
  RxBool isLoading = false.obs;


  ///========================> amount Send <=====================


  TextEditingController amountController = TextEditingController();
  TextEditingController receiveController = TextEditingController();

  Future<void> exchangeRates() async {
    print("exchangeRates");

    try {

      final url = Uri.parse(ApiUrl.exchangeApi);

      var response = await http.get(url);
      print(response.statusCode.toString());


      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        var data = jsonData['rates'];

        success.value = jsonData["success"];
        xafRate.value = data["XAF"];
        rubRate.value = data["RUB"];

        print(rubRate.toString());
        print(xafRate.toString());
        print(success.toString());
      } else {

      }
    } catch (e) {
      print("error");
    }
  }
  Future<void> youPay(String stringAmount) async {
    print(stringAmount);

    if (success.value) {
      var amount = double.parse(stringAmount);
      var rate = xafRate.value / rubRate.value;
      var receiveAmount = rate * amount;
      receiveController.text = receiveAmount.toString();
    } else {
      print("api not hit");
    }
  }
  Future<void> receiveAmount(String stringAmount) async {
    print(stringAmount);

    if (success.value) {
      var amount = double.parse(stringAmount);
      var rate = rubRate.value / xafRate.value;
      var receiveAmount = rate * amount;
      amountController.text = receiveAmount.toString();
    } else {
      print("api not hit");
    }
  }





  ///========================> recipient Information <=====================




  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();


  NetworkApiService networkApiService = NetworkApiService();
  Future<void> hiddenFeeRepo(String token) async {
    print("===================> hiddenFeeRepo");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi(ApiUrl.hiddenFee, header)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        hiddenFeesModelInfo = HiddenFeesModel.fromJson(json);
      } else if (apiResponseModel.statusCode == 201) {
        var json = jsonDecode(apiResponseModel.responseJson);

        hiddenFeesModelInfo = HiddenFeesModel.fromJson(json);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }























}
