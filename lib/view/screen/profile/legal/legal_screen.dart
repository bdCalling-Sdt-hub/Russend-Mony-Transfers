import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Legal".tr, fontSize: 24.sp,),
              const SizedBox(height: 24,),
              CustomText(text: "Terms of Services".tr, fontSize: 18.sp, color: AppColors.primaryColor,),
              const SizedBox(height: 24,),

              CustomText(text: "Terms of money transfer".tr, fontSize: 18.sp, color: AppColors.primaryColor,),
              const SizedBox(height: 24,),
              CustomText(text: "Personal Data Policy".tr, fontSize: 18.sp, color: AppColors.primaryColor,),
              const SizedBox(height: 24,),
              CustomText(text: "Refund and Cancellation Policy".tr, fontSize: 18.sp, color: AppColors.primaryColor,),

              SizedBox(height: 24.h,)

            ],

          ),
        ),
      ),
    );
  }
}