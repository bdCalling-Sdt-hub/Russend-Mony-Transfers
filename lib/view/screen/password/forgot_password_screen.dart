import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/forget_password_controller.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/widgets/loading_container/loading_container.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../core/app_route/app_route.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/custom_button/custom_button.dart';
import '../../widgets/custom_text_field/custom_text_field.dart';
import '../../widgets/image/custom_image.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: "Reset Password".tr,
                          fontSize: 18.sp,
                          top: 16.h,
                          bottom: 16.h,
                        ),
                      ),
                      CustomText(
                        text: "Please enter your Email  to reset your password"
                            .tr,
                        fontSize: 18.sp,
                        maxLines: 2,
                        style: true,
                        color: AppColors.black50,
                        textAlign: TextAlign.start,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                            text: "Email".tr,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                            top: 27.h),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      CustomTextField(
                        fillColor: AppColors.gray80,
                        controller: forgetPasswordController.emailController,
                        hintText: "Enter your email".tr,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter your email".tr;
                          }
                        },
                        suffixIcon: Padding(
                            padding: EdgeInsets.all(14.w),
                            child: CustomImage(
                              imageSrc: AppIcons.mail,
                              imageType: ImageType.svg,
                              size: 24.h,
                            )),
                      ),
                      SizedBox(
                        height: 300.h,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => forgetPasswordController.isLoadingEmailScreen.value
                            ? LoadingContainer()
                            : CustomButton(
                                titleText: "Reset Password".tr,
                                buttonRadius: 12.r,
                                buttonWidth: double.infinity,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    forgetPasswordController
                                        .forgetPasswordRepo();
                                  }
                                  // Get.toNamed(AppRoute.forgotPasswordVerify);
                                }),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Already have an account? ".tr,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          GestureDetector(
                              onTap: () => Get.toNamed(AppRoute.createAccount),
                              child: CustomText(
                                text: "Sign in".tr,
                                fontSize: 15.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
