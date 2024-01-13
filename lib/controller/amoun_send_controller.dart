import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:money_transfers/utils/api_url.dart';

class AmountSendController extends GetxController {
  RxInt amount = 0.obs;
  RxDouble xafRate = 0.0.obs;
  RxDouble rubRate = 0.0.obs;
  RxBool success = false.obs;

  TextEditingController amountController = TextEditingController();

  TextEditingController receiveController = TextEditingController();

  Future<void> exchangeRates() async {
    try {
      print("call");
      final url = Uri.parse(ApiUrl.exchangeApi);

      var response = await http.get(url);

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
}
