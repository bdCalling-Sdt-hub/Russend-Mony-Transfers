import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../core/app_route/app_route.dart';
import '../../global/api_response_model.dart';

class NetworkApiService {
  Future<ApiResponseModel> postApi(String url, Map body, dynamic headers) async {
    dynamic responseJson;

    try {
      final response =
          await http.post(Uri.parse(url), body: body, headers: headers);
      responseJson = handleResponse(response);
    } on SocketException {
      return ApiResponseModel(503, "No internet connection", '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request", '');
    }

    return responseJson;
  }

  dynamic handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponseModel(200, 'Success', response.body);
      case 201:
        return ApiResponseModel(201, 'Success', response.body);
      case 401:
        Get.offAllNamed(AppRoute.logIn);
        return ApiResponseModel(401, "Unauthorized".tr, response.body);

      default:
        return ApiResponseModel(500, "Internal Server Error".tr, response.body);
    }
  }
}
