import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String accessToken = '';
  static String refreshToken = '';
  static String email = '';
  static String id = '';
  static String localizationLanguageCode = '';
  static String localizationCountryCode = '';
  static bool isLogIn = false;
  static bool isLocalAuth = false;

  Future<void> getSharedPreferenceData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      accessToken = pref.getString("accessToken") ?? "";
      refreshToken = pref.getString("refreshToken") ?? "";
      email = pref.getString("email") ?? "";
      id = pref.getString("id") ?? "";
      localizationLanguageCode = pref.getString("languageCode") ?? "en";
      localizationCountryCode = pref.getString("countryCode") ?? "US";
      isLogIn = pref.getBool("isLogIn") ?? false;
      isLocalAuth = pref.getBool("isLocalAuth") ?? false;

      print("=============================> $localizationLanguageCode") ;
      print("===========================> $localizationCountryCode") ;
    } catch (e) {
      print(e.toString());
    }
  }



  Future<void> logOut() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      pref.setString("accessToken", "");
      pref.setString("refreshToken", "");
      pref.setString("email", "");
      // pref.setString("languageCode", "");
      // pref.setString("countryCode", "");
      pref.setBool("isLogIn", false);
      pref.setBool("isLocalAuth", false);

      Get.offAllNamed(AppRoute.logIn) ;


    } catch (e) {
      print(e.toString());
    }
  }





}
