import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/loading_container/loading_container.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../controller/sign_up/sign_up_controller.dart';
import '../../../../utils/app_utils.dart';
import '../../../widgets/resend_rich_text/resend_rich_text.dart';
import '../../../widgets/rich_text/rich_text.dart';

class SignUpVerification extends StatelessWidget {
  SignUpVerification({super.key});

  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {

    signUpController.isLoading.value = false;
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
                  bottom: 9.h,
                ),
                TextRichWidget(
                    firstText:
                        "Please enter the 6-digit code sent to your email ".tr,
                    firstColor: AppColors.black50,
                    secondText: signUpController.emailController.text,
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
                    controller: signUpController.otpController,
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
                SizedBox(
                  height: 48.h,
                ),
                Obx(() => Center(
                      child: signUpController.isLoading.value
                          ? LoadingContainer(width: 200.w,)
                          : CustomButton(
                              titleText: "Verify".tr,
                              buttonWidth: 200.w,
                              buttonRadius: 10.r,
                              titleSize: 14.sp,
                              onPressed: () {
                                signUpController.signUpAuthRepo();
                              }),
                    )),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  children: [
                    Flexible(
                        child: Align(
                            alignment: Alignment.center,
                            child: Obx(() => ResendRichText(
                              onTap:
                              signUpController.isResend.value
                                  ? () {
                                signUpController
                                    .signUpRepo();
                                Utils.snackBarMessage(
                                    "Resend", "Resend Code");
                              }
                                  : () {
                                Utils.toastMessage(
                                    "please wait ${signUpController.time}");
                              },
                            )))),
                  ],
                ),
                Obx(() => CustomText(
                    text: "You can resend the code in  ${signUpController.time}",
                    fontSize: 16.sp,
                    top: 8.h,
                    style: true,
                    color: AppColors.black40,
                    maxLines: 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
