import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_images.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../utils/app_icons.dart';
import '../../widgets/image/custom_image.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child:
                       CustomImage(imageSrc: AppIcons.splashIcon, size: 180.w),
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomText(
                  text: "Transfer money quickly with Russend".tr,
                  color: AppColors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  maxLines: 4,
                  left: 20.w,
                  right: 20.w,
                ),
                const Spacer(),
                CustomButton(
                  titleText: "Create Account".tr,
                  borderColor: AppColors.white,
                  titleColor: AppColors.black100,
                  buttonColor: AppColors.white50,
                  buttonWidth: double.maxFinite,
                  titleSize: 16.sp,
                  borderWidth: 2.w,
                  onPressed: () => Get.toNamed(AppRoute.createAccount),
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomButton(
                  titleText: "Sign In".tr,
                  borderColor: AppColors.white,
                  titleColor: AppColors.white,
                  buttonWidth: double.maxFinite,
                  titleSize: 16.sp,
                  borderWidth: 3.w,
                  onPressed: () => Get.toNamed(AppRoute.logIn),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}