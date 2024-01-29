import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/payment_info_model.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../models/hidden_fee_model.dart';
import '../services/api_services/api_services.dart';

class AmountSendController extends GetxController {
  // RxInt amount = 0.obs;
  RxDouble xafRate = 6.80.obs;
  RxDouble rubRate = 1.0.obs;
  RxBool success = false.obs;
  RxBool isPay = true.obs;
  RxBool isRepeat = false.obs;

  RxBool disableButton = false.obs;

  final duration = const Duration().obs;
  Timer? timer;
  RxString time = "0:10:00.000000".obs;
  RxString paymentMethod = "Orange Money".obs;

  HiddenFeesModel? hiddenFeesModelInfo;
  PaymentInfoModel? paymentInfoModelInfo;

  RxBool isLoading = false.obs;
  String amountToSentCurrency = "RUB";

  String amountToReceiveCurrency = "XAF";

  RxString countryCode = "+237".obs;
  RxString countryId = "".obs;
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

      print(response.body);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        var data = jsonData['rates'];

        success.value = jsonData["success"];
        xafRate.value = double.parse(data["XAF"].toStringAsFixed(2));
        rubRate.value = double.parse(data["RUB"].toStringAsFixed(2));

        print(xafRate);
        print(rubRate);
      } else {}
    } catch (e) {
      print("error $e");
    }
  }

  ///========================> recipient Information <=====================

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> hiddenFeeRepo() async {
    print("===================> hiddenFeeRepo");

    if (hiddenFeesModelInfo == null) {
      Map<String, String> header = {
        'Authorization': "Bearer ${SharedPreferenceHelper.accessToken}"
      };

      isLoading.value = true;

      networkApiService
          .getApi(ApiUrl.hiddenFee, header)
          .then((apiResponseModel) {
        isLoading.value = false;

        if (apiResponseModel.statusCode == 200) {
          var json = jsonDecode(apiResponseModel.responseJson);
          print(json);
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
      isLoadingFinalScreen.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        paymentInfoModelInfo = PaymentInfoModel.fromJson(json);

        timer?.cancel();
        duration.value = const Duration(minutes: 10);

        startTime();
        time.value = "0:10:00.00000";
        Get.toNamed(AppRoute.paymentMethodFinal);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> addTransactionRepo() async {
    print("===================> object");

    ///=========================================> main Code <============================================
    var body = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "phoneNumber": isRepeat.value
          ? numberController.text
          : "$countryCode${numberController.text}",
      "amountToSent": amountController.text,
      "ammountToSentCurrency": amountToSentCurrency,
      "amountToReceive": receiveController.text,
      "amountToReceiveCurrency": amountToReceiveCurrency,
      "exchangeRate": xafRate.round().toString(),
      "hiddenFees": hiddenFeesModelInfo!.data!.attributes!.isActive!
          ? hiddenFeesModelInfo!.data!.attributes!.percentage.toString()!
          : "0",
      "paymentMethod": paymentMethod.value,
      "country": "$countryId",
    };

    Map<String, String> header = {
      'Authorization': "Bearer ${SharedPreferenceHelper.accessToken}"
    };

    print(body);

    try {
      var apiResponseModel =
          await networkApiService.postApi(ApiUrl.allTransactions, body, header);

      if (apiResponseModel.statusCode == 200) {
        Get.toNamed(AppRoute.transactionSuccessScreen);
        isRepeat.value = false;
      } else if (apiResponseModel.statusCode == 201) {
        Get.toNamed(AppRoute.transactionSuccessScreen);
        isRepeat.value = false;
      } else if (apiResponseModel.statusCode == 401) {
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    } catch (error) {
      // Handle any exceptions that might occur during the API call
      print("Error: $error");
      Get.snackbar("Error", "An error occurred during the API call");
    }
  }

  ///=================================================> Amount Send Keyboard <==========================================

  void youPay(String value, TextEditingController textController) {
    print("xafRate ====================> ${xafRate.value}");
    print("rubRate ====================> ${rubRate.value}");
    if (value == 'Forgot') {
      Get.toNamed(AppRoute.resetPasscode);
    } else if (value == '<') {
      if (textController.text.isNotEmpty) {
        textController.text =
            textController.text.substring(0, textController.text.length - 1);
        if (textController.text.isNotEmpty) {
          var amount = double.parse(textController.text);
          var rate = xafRate.value / rubRate.value;
          var receiveAmount = (rate * amount).round();
          receiveController.text = receiveAmount.toString();
        } else {
          receiveController.text = "";
        }
      } else {
        receiveController.text = "";
      }
    } else {
      textController.text += value;

      var amount = double.parse(textController.text);
      var rate = xafRate.value / rubRate.value;

      // if(hiddenFeesModelInfo!.data!.attributes!.isActive!) {
      //   rate = rate +  ((rate * hiddenFeesModelInfo!.data!.attributes!.percentage!) / 100 ) ;
      //
      // }

      var result = (amount + (amount * 15) / 100);

      var receiveAmount = (rate * result);

      receiveController.text = (receiveAmount).round().toString();

      print("=========================> $rate");
    }
  }

  void receiveAmount(String value, TextEditingController textController) {
    if (value == 'Forgot') {
      Get.toNamed(AppRoute.resetPasscode);
    } else if (value == '<') {
      if (textController.text.isNotEmpty) {
        textController.text =
            textController.text.substring(0, textController.text.length - 1);

        if (textController.text.isNotEmpty) {
          var amount = double.parse(textController.text);
          var rate = rubRate.value / xafRate.value;
          var receiveAmount = (rate * amount).round();
          amountController.text = receiveAmount.toString();
        } else {
          amountController.text = "";
        }
      } else {
        amountController.text = "";
      }
    } else {
      if (textController.text.contains(".") && value == ".") {
      } else {
        textController.text += value;
        var amount = double.parse(textController.text);
        var rate = rubRate.value / xafRate.value;
        if (hiddenFeesModelInfo!.data!.attributes!.isActive!) {
          amount = amount /
              ((hiddenFeesModelInfo!.data!.attributes!.percentage! + 100) /
                  100);
        }

        var receiveAmount = (rate * amount);

        amountController.text = (receiveAmount).round().toString();
      }
    }
  }

  startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = 1;
      final seconds = duration.value.inSeconds - addSeconds;
      duration.value = Duration(seconds: seconds);
      if (time.value != "0:00:00.000000") {
        time.value = duration.toString();
      } else {
        disableButton.value = true;
        timer?.cancel();
      }
    });
  }

  String formattedDuration() {
    // Parse the duration string
    List<String> parts = time.value.split(':');
    Duration duration = Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(
          parts[2].split('.')[0]), // Extract seconds without milliseconds
    );

    // Format the duration as needed
    String formattedDuration =
        "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";

    return formattedDuration;
  }
}
