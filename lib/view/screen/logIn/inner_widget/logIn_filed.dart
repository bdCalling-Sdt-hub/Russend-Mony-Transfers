import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/custom_text_field/custom_text_field.dart';
import '../../../widgets/image/custom_image.dart';
import '../../../widgets/text/custom_text.dart';

class LogInFiled extends StatelessWidget {
  const LogInFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Get started with Russend",
          fontSize: 20.sp,
          top: 28.h,
          fontWeight: FontWeight.w600,
        ),
        CustomText(
            text: "Email".tr,
            fontSize: 14.sp,
            style: true,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            top: 27.h),
        CustomTextField(
          fillColor: AppColors.gray80,
          hintText: "Enter your email".tr,
          suffixIcon: Padding(
              padding: EdgeInsets.all(14.w),
              child: CustomImage(
                imageSrc: AppIcons.mail,
                imageType: ImageType.svg,
                size: 24.h,
              )),
        ),
        CustomText(
            text: "Password".tr,
            fontSize: 14.sp,
            style: true,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
            top: 22.h),
        CustomTextField(
          fillColor: AppColors.gray80,
          isPassword: true,
          hintText: "Password".tr,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoute.forgotPassword),
            child: CustomText(
              text: "Forgot password".tr,
              textAlign: TextAlign.end,
              fontSize: 10.sp,
              style: true,
              color: AppColors.primaryColor,
              right: 8.w,
              top: 12.w,
              bottom: 200.h,
            ),
          ),
        ),
      ],
    );
  }
}