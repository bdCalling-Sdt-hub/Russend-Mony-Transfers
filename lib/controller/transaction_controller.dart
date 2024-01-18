import 'dart:convert';

import 'package:get/get.dart';
import 'package:money_transfers/models/transaction_details_model.dart';
import 'package:money_transfers/models/transaction_model.dart';

import '../core/app_route/app_route.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class TransactionController extends GetxController {

  TransactionModel? transactionModelInfo ;

  TransactionDetailsModel? transactionDetailsModelInfo  ;

  RxBool isLoading = false.obs;

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> transactionRepo(String token) async {
    print("===================> object");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi(ApiUrl.transaction, header)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        transactionModelInfo = TransactionModel.fromJson(json);

        Get.toNamed(AppRoute.transaction);
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }



  Future<void> transactionDetailsRepo(String token, String id) async {
    print("===================> transactionDetailsRepo");

    Map<String, String> header = {'Authorization': "Bearer $token"};

    isLoading.value = true;

    networkApiService
        .getApi("${ApiUrl.transaction}/$id", header)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {

        var json = jsonDecode(apiResponseModel.responseJson);
        transactionDetailsModelInfo = TransactionDetailsModel.fromJson(json) ;
        Get.toNamed(AppRoute.transactionHistory) ;

      }else if (apiResponseModel.statusCode == 201) {

        var json = jsonDecode(apiResponseModel.responseJson);
        transactionDetailsModelInfo = TransactionDetailsModel.fromJson(json) ;
        Get.toNamed(AppRoute.transactionHistory);

      }

      else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
