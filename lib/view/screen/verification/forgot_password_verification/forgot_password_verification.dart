import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../widgets/resend_rich_text/resend_rich_text.dart';
import '../../../widgets/rich_text/rich_text.dart';

class ForgotPasswordVerification extends StatelessWidget {
  ForgotPasswordVerification({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: "Enter the verification code".tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    bottom: 16.h),
                TextRichWidget(
                    firstText:
                        "Please enter the 6-digit code sent to your email ".tr,
                    firstColor: AppColors.black50,
                    secondText: "hemmykhom@gmail.com",
                    secondColor: AppColors.black75,
                    thirdText: " to verify your email.".tr,
                    thirdColor: AppColors.black50),
                SizedBox(
                  height: 24.h,
                ),
                Flexible(
                  flex: 0,
                  child: PinCodeTextField(
                    cursorColor: AppColors.black100,
                    // controller: controller.otpController,
                    appContext: (context),

                    validator: (value) {
                      if (value!.length < 6) {
                        return "Please enter the OTP code.".tr;
                      } else {}
                    },
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50.h,
                      fieldWidth: 46.w,
                      activeFillColor: AppColors.transparentColor,
                      selectedFillColor: AppColors.transparentColor,
                      inactiveFillColor: AppColors.transparentColor,
                      borderWidth: 0.5.w,
                      errorBorderColor: AppColors.primaryColor,
                      selectedColor: AppColors.black100,
                      activeColor: AppColors.black100,
                      inactiveColor: AppColors.black100,
                    ),
                    length: 6,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.disabled,
                    enableActiveFill: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: CustomButton(
                    titleText: "Verify".tr,
                    buttonRadius: 10.r,
                    titleSize: 16.sp,
                    buttonWidth: 220.w,
                    onPressed: () => Get.toNamed(AppRoute.newPassword),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                const Row(
                  children: [
                    Flexible(child: Align(
                      alignment: Alignment.center,
                        child: ResendRichText())),
                  ],
                ),
                CustomText(
                    text: "You can resend the code in 00:59".tr,
                    fontSize: 16.sp,
                    top: 8.h,
                    style: true,
                    color: AppColors.black40,
                    maxLines: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
