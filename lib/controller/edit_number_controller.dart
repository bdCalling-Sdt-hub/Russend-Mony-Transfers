
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/api_services/api_services.dart';

class EditNumberController extends GetxController {
  RxString countryCode = "".obs;

  RxBool isLoading = false.obs;
  TextEditingController numberController = TextEditingController();

  NetworkApiService networkApiService = NetworkApiService();
}
