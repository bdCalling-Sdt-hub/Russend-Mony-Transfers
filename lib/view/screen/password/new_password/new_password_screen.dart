import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/app_route/app_route.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/back/back.dart';
import '../../../widgets/custom_button/custom_button.dart';
import '../../../widgets/custom_text_field/custom_text_field.dart';
import '../../../widgets/text/custom_text.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Reset Password".tr,
                fontSize: 20.sp,
                top: 29.h,
                fontWeight: FontWeight.w600,
                bottom: 32.h,
              ),
              CustomText(
                text: "New password".tr,
                fontSize: 14.r,
                style: true,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                bottom: 4.h,
              ),
              CustomTextField(
                fillColor: AppColors.gray80,
                isPassword: true,
                hintText: "Enter your new password".tr,
              ),
              CustomText(
                text: "Confirm password".tr,
                fontSize: 14.r,
                style: true,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                top: 24.h,
                bottom: 4.h,
              ),
              CustomTextField(
                fillColor: AppColors.gray80,
                isPassword: true,
                hintText: "Confirm your new password".tr,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: CustomButton(
            titleText: "Reset Password".tr,
            buttonRadius: 10.r,
            onPressed: () {
              Get.toNamed(AppRoute.createSuccessful);
            }),
      ),
    );
  }
}
