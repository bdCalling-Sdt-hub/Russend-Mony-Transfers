import 'dart:convert';

import 'package:get/get.dart';
import '../../global/api_url.dart';
import 'package:http/http.dart' as http;
import '../../services/get_api/get_api_services.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;

  String otp = "";

  NetworkApiService networkApiService = NetworkApiService();

  // Future<void> signUp() async {
  //   print("object");
  //
  //   var body = {
  //     "fullName": "Naimul Hassan",
  //     "email": "nayem20012@gmail.com",
  //     "phoneNumber": "01714455468",
  //     "password": "hello123"
  //   };
  //
  //   var header = {
  //     "Otp": "OTP $otp",
  //     "Content-Type": "application/json",
  //   };
  //
  //   networkApiService.postApi(ApiUrl.signUp, body, header).then((value) {
  //     ApiResponseModel apiResponseModel = value;
  //     print(apiResponseModel.statusCode);
  //
  //     if (apiResponseModel.statusCode == 200) {
  //       Get.toNamed(AppRoute.phoneNumberOtp);
  //       print(apiResponseModel.message);
  //       print(apiResponseModel.responseJson);
  //
  //     }
  //   });
  // }

  Future<void> signUp() async {
    try {
      var body = {
        "fullName":"Naimul Hassan",
        "email":"sdjfjfsjdjssfdddj@gmail.com",
        "phoneNumber":"01714455468",
        "password":"hello123"
      };
      print("===================>$body");
      Map<String, String> headers = {
        'Otp': 'OTP',
        // "Content-Type": "application/json"
      };

      print("======================Url$headers");
      final url = Uri.parse(ApiUrl.signUp);
      print("======================Url$url");
      final response = await http.post(url, headers: headers, body: body);
      print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        print(jsonDecode(response.body));
      }

      print("object");
    } catch (e) {
      print("============> error \n $e") ;

    }

  }
}
