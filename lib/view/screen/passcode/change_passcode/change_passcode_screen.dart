import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/keyboard/custom_keyboard.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../widgets/back/back.dart';

class ChangePasscode extends StatelessWidget {
  ChangePasscode({super.key});

  TextEditingController controller = TextEditingController();

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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Enter your current passcode".tr,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                bottom: 44.h,
              ),
              Flexible(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: PinCodeTextField(
                    controller: controller,
                    cursorColor: AppColors.black100,
                    obscureText: true,
                    enablePinAutofill: true,
                    obscuringCharacter: "*",
                    // controller: controller.otpController,
                    appContext: (context),

                    validator: (value) {
                      if (value!.length != 4) {
                        return null;
                      } else {
                        // return "Please enter passcode".tr;
                      }
                    },
                    autoFocus: true,
                    showCursor: false,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.circle,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 12.h,
                      fieldWidth: 12.w,
                      activeFillColor: Colors.black,
                      selectedFillColor: AppColors.transparentColor,
                      inactiveFillColor: AppColors.transparentColor,
                      borderWidth: 0.0.w,
                      errorBorderColor: AppColors.primaryColor,
                      selectedColor: AppColors.black100,
                      activeColor: AppColors.transparentColor,
                      inactiveColor: AppColors.black100,
                    ),
                    length: 4,
                    keyboardType: TextInputType.none,
                    enableActiveFill: true,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: CustomButton(
                  titleText: "Continue".tr,
                  buttonRadius: 50.r,
                  titleSize: 14.sp,
                  buttonWidth: 150.w,

                  onPressed: () => Get.toNamed(AppRoute.newPasscode),
                ),
              ),
              CustomKeyboard(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}
