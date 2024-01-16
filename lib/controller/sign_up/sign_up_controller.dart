import 'dart:convert';

import 'package:get/get.dart';
import '../../global/api_url.dart';
import 'package:http/http.dart' as http;
import '../../services/get_api/get_api_services.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;

  String otp = "";

  NetworkApiService networkApiService = NetworkApiService();


  RxList userList = [].obs;

  var accessToken  = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWE2Mzg3YmY2OTk1Y2Q1NTJhMzAxOTIiLCJlbWFpbCI6ImRldmVsb3Blcm5haW11bDAwQGdtYWlsLmNvbSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzA1NDExMDkxLCJleHAiOjE3MDgwMDMwOTF9.ueDlH3JfrZwUEDDHCHndbeHhRUAoULsJ1Ui4euo71rE" ;




  // Future<void> signUp() async {
  //   print("===================> object");
  //
  //   Map<String, String> header = {
  //     'Authorization': "Bearer $accessToken"
  //   };
  //
  //
  //   networkApiService.getApi(ApiUrl.allTransactions, header)
  //       .then((apiResponseModel) {
  //
  //        print( apiResponseModel.statusCode ) ;
  //        print( apiResponseModel.message ) ;
  //        print( apiResponseModel.responseJson ) ;
  //   });

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
        var headers = {
          'Otp': 'OTP ',
          'Content-Type': 'application/json',
          'Cookie': 'i18next=en'
        };
        var request = http.Request('POST', Uri.parse('https://192.168.10.18:3000/api/users/sign-up'));
        request.body = json.encode({
          "fullName": "Naimul Hassan",
          "email": "sdjfjihffffsjdjfdddj@gmail.com",
          "phoneNumber": "01714455468",
          "password": "hello123"
        });
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        print("============> success") ;

        if (response.statusCode == 200) {

          print(await response.stream.bytesToString());
        }
        else {
          print(response.reasonPhrase);
        }
        // var body = {
        //   "fullName":"Naimul Hassan",
        //   "email":"sdjfjfsjdjssfdddj@gmail.com",
        //   "phoneNumber":"01714455468",
        //   "password":"hello123"
        // };
        // print("===================>$body");
        // Map<String, String> headers = {
        //   "Content-Type": "application/json",
        //   'Otp': 'OTP',
        // };
        //
        // print("======================Url$headers");
        // final url = Uri.parse(ApiUrl.signUp);
        // print("======================Url$url");
        // final response = await http.post(url, body: body);
        // print("response");
        // if (response.statusCode == 200) {
        //   var data = jsonDecode(response.body);
        //   print(data);
        //   print(jsonDecode(response.body));
        // }
        //
        // print("object");
      } catch (e) {
        print("============> error \n $e") ;

      }

    }
  }

