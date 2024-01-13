import 'package:flutter/services.dart';
import 'package:money_transfers/utils/app_colors.dart';

class DeviceUtils{

  static splashUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.black100,
            systemNavigationBarIconBrightness: Brightness.light
        )
    );
  }

  static onboardUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Color(0xFFF4F4F4),
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }

  static authUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.transparentColor,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }

  static bottomNavUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.black100,
            systemNavigationBarIconBrightness: Brightness.light
        )
    );
  }

  static innerUtils() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: AppColors.transparentColor,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: AppColors.white,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );
  }
}