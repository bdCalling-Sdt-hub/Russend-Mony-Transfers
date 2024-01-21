import 'dart:convert';

import 'package:get/get.dart';
import 'package:money_transfers/models/content_model.dart';
import 'package:money_transfers/view/widgets/flutter_content/content_screen.dart';

import '../global/api_url.dart';
import '../services/api_services/api_services.dart';

class LegalController extends GetxController {
  ContentModel? termsOfMoneyTransferInfo;
  ContentModel? termsOfServiceInfo;
  ContentModel? personalDataPolicyInfo;
  ContentModel? refundAndCancellationPolicyInfo;

  RxBool isLoading = false.obs;

  NetworkApiService networkApiService = NetworkApiService();

  Future<void> termsOfMoneyTransferRepo() async {

    Get.to(ContentScreen());

    print("===================> termsOfMoneyTransferRepo");

    Map<String, String> header = {};

    isLoading.value = true;

    networkApiService
        .getApi(ApiUrl.termsOfMoneyTransfer, header, isHeader: false)
        .then((apiResponseModel) {


      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        termsOfMoneyTransferInfo = ContentModel.fromJson(json);

        print(termsOfMoneyTransferInfo!.data!.attributes!.content.toString());

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }



  Future<void> termsOfServiceRepo() async {
    print("===================> termsOfServiceRepo");

    Get.to(ContentScreen());


    Map<String, String> header = {};

    isLoading.value = true;

    networkApiService
        .getApi(ApiUrl.termsOfService, header, isHeader: false)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        termsOfMoneyTransferInfo = ContentModel.fromJson(json);

        print(termsOfMoneyTransferInfo!.data!.attributes!.content.toString());

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> personDataPolicyRepo() async {
    print("===================> personDataPolicyRepo");

    Get.to(ContentScreen());


    Map<String, String> header = {};

    isLoading.value = true;

    networkApiService
        .getApi(ApiUrl.personalDataPolicies, header, isHeader: false)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        personalDataPolicyInfo = ContentModel.fromJson(json);

        print(personalDataPolicyInfo!.data!.attributes!.content.toString());

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> refundAndCancellationPolicyRepo() async {
    print("===================> refundAndCancellationPolicyRepo");
    Get.to(ContentScreen());


    Map<String, String> header = {};

    isLoading.value = true;

    networkApiService
        .getApi(ApiUrl.refundAndCancellationPolicy, header, isHeader: false)
        .then((apiResponseModel) {
      print(apiResponseModel.statusCode);
      print(apiResponseModel.message);
      print(apiResponseModel.responseJson);

      isLoading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        refundAndCancellationPolicyInfo = ContentModel.fromJson(json);

        print(refundAndCancellationPolicyInfo!.data!.attributes!.content
            .toString());

      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }
}
