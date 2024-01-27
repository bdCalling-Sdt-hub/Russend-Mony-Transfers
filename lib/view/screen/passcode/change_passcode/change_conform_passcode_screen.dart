import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/confirm_new_passcode_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_utils.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/keyboard/custom_keyboard.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ChangeConformPasscodeScreen extends StatelessWidget {
  ChangeConformPasscodeScreen({super.key});

  ConfirmPasscodeController confirmPasscodeController =
      Get.put(ConfirmPasscodeController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Confirm your new passcode".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  bottom: 44.h,
                  top: 84.h,
                ),
                Flexible(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: PinCodeTextField(
                      controller:
                          confirmPasscodeController.confirmPasscodeController,
                      cursorColor: AppColors.black100,
                      obscureText: true,
                      enablePinAutofill: true,
                      obscuringCharacter: "*",
                      // controller: controller.otpController,
                      appContext: (context),
                      onTap: () {
                        confirmPasscodeController.disableKeyboard.value = false;
                      },
                      onChanged: (value) {
                        print(value);
                        if (value.length == 4) {
                          confirmPasscodeController.disableKeyboard.value =
                              true;
                        }
                      },

                      validator: (value) {
                        if (value!.length == 4) {
                          return null;
                        } else {
                          return "Please enter passcode".tr;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      enableActiveFill: true,
                    ),
                  ),
                ),
                Obx(() => confirmPasscodeController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox()),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: CustomButton(
                    titleText: "Save".tr,
                    buttonRadius: 50.r,
                    titleSize: 14.sp,
                    buttonWidth: 150.w,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (confirmPasscodeController
                                .newPasscodeController.value ==
                            confirmPasscodeController
                                .confirmPasscodeController.value) {
                          confirmPasscodeController.changePasscodeRepo();
                        } else {
                          Utils.toastMessage("passcode not match".tr);
                        }
                      }
                    },
                  ),
                ),
                Obx(() => confirmPasscodeController.disableKeyboard.value
                    ? const SizedBox()
                    : CustomKeyboard(
                        controller: confirmPasscodeController
                            .confirmPasscodeController))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
