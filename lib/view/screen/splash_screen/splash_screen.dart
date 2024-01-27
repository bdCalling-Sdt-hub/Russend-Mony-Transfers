import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  @override
  void initState() {
    sharedPreferenceHelper.getSharedPreferenceData() ;
    Timer(const Duration(seconds: 3), () {
      getIsLogIn();
    });
    super.initState();
  }

  Future<void> getIsLogIn() async {
    try {
      if (SharedPreferenceHelper.isLogIn) {
        Get.toNamed(AppRoute.enterPassCode);
      } else {
        Get.offAllNamed(AppRoute.onboardScreen);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: CustomImage(imageSrc: AppIcons.splashIcon, size: 100.h),
        ),
      ),
    );
  }
}
