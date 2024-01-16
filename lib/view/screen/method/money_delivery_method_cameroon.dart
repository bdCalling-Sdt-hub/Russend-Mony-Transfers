import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_images.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class MoneyDeliveryMethodCameroon extends StatelessWidget {
  const MoneyDeliveryMethodCameroon({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                    text: "Select how to deliver money to recipient".tr,
                    fontSize: 26.sp,
                    bottom: 24.h,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.recipient),
                        child: Container(
                          height: 100.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1.w,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.white,
                          ),
                          child: Image.asset(
                            AppImages.orangeMoney,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.recipient),
                        child: Container(
                          height: 100.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.white,
                          ),
                          child: Image.asset(
                            AppImages.mtn,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: "Should arrive in".tr),
                      CustomText(
                          text: " a few minutes".tr,
                          color: AppColors.primaryColor),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: "0%".tr, color: AppColors.primaryColor),
                      CustomText(text: " Fee".tr),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}