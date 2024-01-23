import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/payment_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../models/hidden_fee_model.dart';
import '../services/api_services/api_services.dart';
import '../utils/app_utils.dart';

class AmountSendController extends GetxController {
  // RxInt amount = 0.obs;
  RxDouble xafRate = 6.80.obs;
  RxDouble rubRate = 1.0.obs;
  RxBool success = false.obs;
  HiddenFeesModel? hiddenFeesModelInfo;
  PaymentInfoModel? paymentInfoModelInfo;

  RxBool isLoading = false.obs;
  String amountToSentCurrency = "RUB";

  String amountToReceiveCurrency = "XAF";

  RxString countryCode = "+237".obs;
  RxString countryId = "".obs;
  String time = "9 : 25";
  RxBool isLoadingFinalScreen = false.obs;
  RxBool isLoadingFinalScreenButton = false.obs;
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  ///========================> amount Send <=====================

  TextEditingController amountController = TextEditingController();
  TextEditingController receiveController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

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
      } else {}
    } catch (e) {
      print("error");
    }
  }

  Future<void> youPay(String stringAmount) async {
    print(stringAmount);

    // if (success.value) {
      var amount = double.parse(stringAmount);
      var rate = xafRate.value / rubRate.value;
      var receiveAmount = rate * amount;
      print("================================> $receiveAmount") ;
      receiveController.text = receiveAmount.toString();
    // } else {
    //   print("api not hit");
    // }
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

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> hiddenFeeRepo(String token) async {
    print("===================> hiddenFeeRepo");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService.getApi(ApiUrl.hiddenFee, header).then((apiResponseModel) {
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

  ///========================> payment method final Screen <=====================

  //
  // String name = "Cedric william";
  // String receiverName = "ричард манни в";
  //
  // String amount = "12350 XAF ";
  // String amountRub = "1500 RUB";
  // String paymentId = "Сбербанк (sberbank)";
  // String number = "+79050048977";

  Future<void> paymentInfoRepo() async {
    print("===================> paymentInfoRepo");

    Map<String, String> header = {};

    isLoadingFinalScreen.value = true;

    networkApiService
        .getApi(ApiUrl.paymentInfo, header, isHeader: false)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);
      isLoadingFinalScreen.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        paymentInfoModelInfo = PaymentInfoModel.fromJson(json);
        Get.toNamed(AppRoute.paymentMethodFinal);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> getIsisLogIn() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      sharedPreferenceHelper.accessToken = pref.getString("accessToken") ?? "";
      sharedPreferenceHelper.isLogIn = pref.getBool("isLogIn") ?? false;
      print(
          "Transaction ====================================> ${sharedPreferenceHelper.accessToken.toString()}");

      addTransactionRepo(sharedPreferenceHelper.accessToken);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addTransactionRepo(String token) async {
    print("===================> object");

    Map<String, String> body = {
      "firstName": "Shakib",
      "lastName": "Elahi",
      "phoneNumber": "01745589658",
      "amountToSent": 5000.toString(),
      "ammountToSentCurrency": "RUB",
      "amountToReceive": 15000.toString(),
      "amountToReceiveCurrency": "XAF",
      "exchangeRate": 30.toString(),
      "hiddenFees": 3.toString(),
      "paymentMethod": "Orange Money",
      "country": "65aa15210b9179adf1c4b6b7"
    };

    print("===================>$body");
    Map<String, String> header = {'Authorization': "Bearer $token"};

    try {
      var apiResponseModel = await networkApiService.postApi(ApiUrl.allTransactions, body, header);

      print("apiResponseModel");
      print(apiResponseModel.statusCode.toString());
      print(apiResponseModel.message.toString());
      print(apiResponseModel.responseJson.toString());

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        // Get.toNamed(AppRoute.enterPassCode);
      } else if (apiResponseModel.statusCode == 201) {
        var json = jsonDecode(apiResponseModel.responseJson);
        // Get.toNamed(AppRoute.enterPassCode);
      } else if (apiResponseModel.statusCode == 401) {
        var data = jsonDecode(apiResponseModel.responseJson);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    } catch (error) {
      // Handle any exceptions that might occur during the API call
      print("Error: $error");
      Get.snackbar("Error", "An error occurred during the API call");
    }

    print("===================>fdhfhfd");
  }

}
