import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(onTap: () => Get.toNamed(AppRoute.notification),child: CustomImage(imageSrc: AppIcons.bell, size: 24.h)),
              GestureDetector(onTap: () => Get.toNamed(AppRoute.profile),child: CustomImage(imageSrc: AppIcons.profile, size: 24.h)),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: "Recent transaction".tr, fontSize: 26.sp),
              CustomText(
                  text: "OCTOBER 2023".tr,
                  fontSize: 16.sp,
                  color: AppColors.black50,
                  top: 24.h,
                  bottom: 30.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.transactionHistory),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 50.h,
                                width: 50.w,
                                padding: EdgeInsets.all(4.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1.w,
                                        style: BorderStyle.solid),
                                    shape: BoxShape.circle,
                                    color: AppColors.gray20),
                                child: const CustomImage(imageSrc: AppIcons.arrow),
                              ),
                              Positioned(
                                bottom: 0,right: 0,
                                child: Container(
                                  height: 15.h,width: 15.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: AssetImage(AppIcons.flag),fit: BoxFit.fill)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(child: CustomText(text: "ADRIEN WANDJI",fontSize: 18.sp,fontWeight: FontWeight.w600,right: 24.h,textAlign: TextAlign.start)),
                                    CustomText(text: "99,000 XAF",fontSize: 18.sp,fontWeight: FontWeight.w600),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(text: "To mobile .. 8060",fontSize: 14.sp,fontWeight: FontWeight.w600,color: AppColors.black50,textAlign: TextAlign.start),
                                    CustomImage(imageSrc: AppIcons.success,size: 15.h,imageColor: AppColors.black100,)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: CustomButton(titleText: "Send".tr,buttonRadius: 25.r,onPressed: () => Get.toNamed(AppRoute.selectCountry),),
        ),
      ),
    );
  }
}
