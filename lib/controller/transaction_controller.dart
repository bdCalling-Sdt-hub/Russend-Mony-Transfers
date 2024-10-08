import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/transaction_details_model.dart';
import 'package:money_transfers/models/transaction_model.dart';
import '../global/api_url.dart';
import '../services/api_services/api_services.dart';
import 'package:intl/intl.dart';

class TransactionController extends GetxController {
  TransactionModel? transactionModelInfo;

  TransactionDetailsModel? transactionDetailsModelInfo;
  RxList transactionList = [].obs;

  RxBool isMoreLoading = false.obs;
  RxBool historyDetailsLoading = false.obs;
  RxBool loading = false.obs;
  int page = 1;

  ScrollController scrollController = ScrollController();

  NetworkApiService networkApiService = NetworkApiService();
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  int start = 0;
  Timer? timer;

  String time = "00:30";

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    start = 30; // Reset the start value
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = "$minutes:$seconds";
        if (kDebugMode) {
          print(time);
        }

        update();
      } else {
        page = 1;
        await transactionRepo(isUpdate: true);
        start = 30;
        update();
      }
    });
  }

  @override
  void onInit() {
    transactionRepo();
    scrollController.addListener(() {
      scrollControllerCall();
    });
    super.onInit();
  }

  Future<void> scrollControllerCall() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await transactionRepo();
    } else {}
  }

  Future<void> transactionRepo({isUpdate = false}) async {
    Map<String, String> header = {
      'Authorization': "Bearer ${SharedPreferenceHelper.accessToken}"
    };

    print("call");
    isMoreLoading.value = true;
    if (transactionList.isEmpty) {
      loading.value = true;
    }

    networkApiService
        .getApi("${ApiUrl.transaction}?page=$page", header)
        .then((apiResponseModel) {
      isMoreLoading.value = false;
      loading.value = false;

      if (apiResponseModel.statusCode == 200) {
        var json = jsonDecode(apiResponseModel.responseJson);

        if (isUpdate) {
          transactionList.clear();
        }

        transactionModelInfo = TransactionModel.fromJson(json);

        for (var item
            in transactionModelInfo!.data!.attributes!.transactionList!) {
          transactionList.add(item);
        }

        page = page + 1;
      } else {
        Get.snackbar(
            apiResponseModel.statusCode.toString(), apiResponseModel.message);
      }
    });
  }

  Future<void> transactionDetailsRepo(String id) async {
    Map<String, String> header = {
      'Authorization': "Bearer ${SharedPreferenceHelper.accessToken}"
    };

    historyDetailsLoading.value = true;

    transactionDetailsModelInfo = null;

    networkApiService
        .getApi("${ApiUrl.transaction}/$id", header)
        .then((apiResponseModel) {
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

      historyDetailsLoading.value = false;
      update();
    });
  }

  String formattedDate() {
    DateTime currentTime = DateTime.now();
    // Assuming transactionController.currentTime is a DateTime object
    DateTime originalDate = currentTime;
    return DateFormat.yMMMMd().format(originalDate);
  }

  String currentDate() {
    final now = DateTime.now();
    String formatter = DateFormat('d.MM.yy').format(now); // 28/03/2020
    return formatter.toString();
  }

  String historyScreenDateFormat(String date) {
    List<String> dateParts = date.split('-');

    int year = int.parse(dateParts[0]);

    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    final dateFormat = DateFormat('d MMMM, yyyy', 'en');
    final currentDate =
        DateTime(year, month, day); // Replace with your actual date
    return dateFormat.format(currentDate);
  }

  // String formattedDuration(String time) {
  //
  //   // Parse the duration string
  //   List<String> parts = time.split(':');
  //   Duration duration = Duration(
  //     hours: int.parse(parts[0]),
  //     minutes: int.parse(parts[1]),
  //     seconds: int.parse(
  //         parts[2].split('.')[0]), // Extract seconds without milliseconds
  //   );
  //
  //   // Format the duration as needed
  //   String formattedDuration =
  //       "${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}";
  //
  //   return formattedDuration;
  // }

  String formattedDuration(String time, String date) {
    List<String> dateParts = date.split('-');

    int year = int.parse(dateParts[0]);

    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    // Parse the duration string
    List<String> parts = time.split(':');
    Duration duration = Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(
        parts[2].split('.')[0], // Extract seconds without milliseconds
      ),
    );

    final utcTime = DateTime.utc(year, month, day, duration.inHours % 60,
        duration.inMinutes % 60, duration.inSeconds % 60);
    final localTime = utcTime.toLocal();

    // Format the duration as needed with AM/PM
    String period = localTime.hour >= 12 ? 'PM' : 'AM';
    int formattedHours = localTime.hour % 12 == 0 ? 12 : localTime.hour % 12;
    String formattedDuration =
        "$formattedHours:${(localTime.minute).toString().padLeft(2, '0')} $period";

    return formattedDuration;
  }
}
