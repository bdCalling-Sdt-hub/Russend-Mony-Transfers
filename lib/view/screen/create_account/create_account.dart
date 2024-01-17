import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/sign_up/sign_up_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/screen/create_account/inner_widget/create_account_all_filed.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import 'inner_widget/create_account_rich_Text.dart';
import 'inner_widget/already_have_account.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  SignUpController signUpController = Get.put(SignUpController());
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var h = height / 852;

    return Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,

        // Main Code
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: CustomImage(
                imageSrc: AppIcons.language,
                imageColor: AppColors.black100,
                size: 20.sp),
          ),
          title: CustomText(
              text: "English".tr, fontSize: 20.sp, fontWeight: FontWeight.w400),
          actions: [
            Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.legalScreen),
                        child: CustomText(
                            text: "Legal terms".tr,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            right: 4.w)),
                    CustomImage(
                      imageSrc: AppIcons.legalTerms,
                      imageColor: AppColors.black100,
                      size: 20.sp,
                    ),
                    SizedBox(
                      width: 15.w,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),

        // sir redesign

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: SingleChildScrollView(
            child:
            Form(
              key: formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomText(
                  text: "Create your account".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  bottom: 15 * h,
                ),
                CreateAccountAllFiled(),
                const Align(
                    alignment: Alignment.center,
                    child: CreateAccountTermsConditions()),
                SizedBox(
                  height: 36 * h,
                ),
                CustomButton(
                  titleText: "Sign up",
                  buttonHeight: 60 * h,
                  titleSize: 16.sp,
                  buttonWidth: double.infinity,
                  titleWeight: FontWeight.w700,
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      signUpController.otpController.text = "" ;
                      signUpController.signUpRepo() ;
                    };
                  },

                ),
                SizedBox(
                  height: 10 * h,
                ),
                const Align(
                    alignment: Alignment.center, child: AlreadyHaveAccount()),
              ]),
            ),
          ),
        ));
  }
}
