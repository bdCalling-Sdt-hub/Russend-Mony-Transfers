import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/create_passcode_controller.dart';
import 'package:money_transfers/controller/sign_up/sign_up_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/models/sign_up_model.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/keyboard/custom_keyboard.dart';

class CreatePasscodeScreen extends StatelessWidget {
  CreatePasscodeScreen({super.key});

  CreatePasscodeController createPasscodeController =
      Get.put(CreatePasscodeController());

  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: AppColors.background,
        body: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Create your passcode".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  bottom: 24.h,
                  top: 100.h,
                ),
                Flexible(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: PinCodeTextField(
                      controller: createPasscodeController.passcodeController,
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
                      onChanged: (controllerLength) {
                        if (controllerLength.length == 4) {
                         Get.toNamed(AppRoute.conformPassCode) ;
                        }
                      },
                      keyboardType: TextInputType.none,
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
                      enableActiveFill: true,
                    ),
                  ),
                ),
                const Spacer(),
                CustomKeyboard(
                  controller: createPasscodeController.passcodeController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
