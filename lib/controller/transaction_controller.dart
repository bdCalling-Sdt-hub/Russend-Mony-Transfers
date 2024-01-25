import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/transaction_details_model.dart';
import 'package:money_transfers/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class TransactionController extends GetxController {
  TransactionModel? transactionModelInfo;

  TransactionDetailsModel? transactionDetailsModelInfo;
  RxList transactionList = [].obs;

  RxBool isLoading = false.obs;
  int page = 1;

  ScrollController scrollController = ScrollController();

  NetworkApiService networkApiService = NetworkApiService();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  @override
  void onInit() {
    getIsisLogIn();
    scrollController.addListener(() {
      scrollControllerCall();
    });
    super.onInit();
  }

  Future<void> getIsisLogIn() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      sharedPreferenceHelper.accessToken =
          pref.getString("accessToken") ?? "aa";
      sharedPreferenceHelper.isLogIn = pref.getBool("isLogIn") ?? false;

      transactionRepo(sharedPreferenceHelper.accessToken);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("calling");
      await transactionRepo(sharedPreferenceHelper.accessToken);
    } else {
      print(" not calling");
    }
  }

  Future<void> transactionRepo(String token) async {
    print("===================> object");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi("${ApiUrl.transaction}?page=$page", header)
        .then((apiResponseModel) {
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        transactionModelInfo = TransactionModel.fromJson(json);

        for (var item
            in transactionModelInfo!.data!.attributes!.transactionList!) {
          transactionList.add(item);
        }

        print(transactionList.length);
        page = page+1 ;

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> transactionDetailsRepo(String token, String id) async {
    print("===================> transactionDetailsRepo");

    transactionDetailsModelInfo = null;
    Get.toNamed(AppRoute.transactionHistory);

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi("${ApiUrl.transaction}/$id", header)
        .then((apiResponseModel) {
      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);
        transactionDetailsModelInfo = TransactionDetailsModel.fromJson(json);
      } else if (apiResponseModel.statusCode == 201) {
        var json = jsonDecode(apiResponseModel.responseJson);
        transactionDetailsModelInfo = TransactionDetailsModel.fromJson(json);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
