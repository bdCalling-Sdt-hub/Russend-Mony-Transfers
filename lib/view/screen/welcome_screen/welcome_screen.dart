import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => Get.offAllNamed(AppRoute.transaction));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImage(imageSrc: AppIcons.appIcon,size: 200.h),
              CustomText(text: "Welcome back, Adrien!".tr,fontSize: 20.sp,fontWeight: FontWeight.w600,top: 18.h)
            ],
          ),
        ),
      ),
    );
  }
}
