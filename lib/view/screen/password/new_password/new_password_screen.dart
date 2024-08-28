import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/models/forget_password_otp_model.dart';
import 'package:money_transfers/view/widgets/loading_container/loading_container.dart';

import '../../../../controller/forget_password_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/custom_button/custom_button.dart';
import '../../../widgets/custom_text_field/custom_text_field.dart';
import '../../../widgets/text/custom_text.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
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
                  controller: forgetPasswordController.passwordController,
                  fillColor: AppColors.gray80,
                  isPassword: true,
                  hintText: "Enter your new password".tr,
                  validator: (value) {
                    return forgetPasswordController.validatePassword(value) ;
                  },
                ),
                CustomText(
                  text: "ConfirmPassword".tr,
                  fontSize: 14.r,
                  style: true,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  top: 24.h,
                  bottom: 4.h,
                ),
                CustomTextField(
                  controller:
                      forgetPasswordController.confirmPasswordController,
                  fillColor: AppColors.gray80,
                  isPassword: true,
                  hintText: "Confirm your new password".tr,
                  validator: (value) {
                    if (forgetPasswordController.passwordController.text == forgetPasswordController.confirmPasswordController.text) {
                      return null;
                    } else {
                      return "password do not match";
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Obx(() => forgetPasswordController.isLoading.value
            ? LoadingContainer()
            : CustomButton(
            titleText: "Reset Password".tr,
            buttonRadius: 10.r,
            onPressed: () {

              if (formKey.currentState!.validate()) {
                ForgetPasswordOtpModel forgetPasswordOtpModel =
                forgetPasswordController.forgetPasswordOtpInfo!;
                forgetPasswordController.resetPasswordRepo(
                    forgetPasswordOtpModel.data!.forgetPasswordToken!);
              }
            })),
      ),
    );
  }
}
