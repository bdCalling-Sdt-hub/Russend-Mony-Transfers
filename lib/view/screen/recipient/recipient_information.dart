import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../core/app_route/app_route.dart';
import '../../../helper/shared_preference_helper.dart';

class RecipientInformation extends StatelessWidget {
  RecipientInformation({super.key});

  AmountSendController amountSendController = Get.put(AmountSendController());

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: "Add recipient’s information".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600),
              CustomText(
                  text: "First Name".tr,
                  fontSize: 18.r,
                  bottom: 8.h,
                  style: true,
                  top: 24.h),
              CustomTextField(
                keyboardType: TextInputType.name,
                controller: AmountSendController.firstNameController,
                fillColor: AppColors.gray80,
                hintText: "Enter the recipient’s First Name".tr,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter the recipient’s First Name".tr;
                  }
                  return null;
                },
                suffixIcon: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: CustomImage(
                      imageSrc: AppIcons.user,
                      imageType: ImageType.svg,
                      size: 24.h,
                    )),
              ),
              CustomText(
                  text: "Last Name".tr,
                  style: true,
                  fontSize: 18.r,
                  bottom: 8.h,
                  top: 24.h),
              CustomTextField(
                fillColor: AppColors.gray80,
                controller: AmountSendController.lastNameController,
                hintText: "Enter the recipient’s Last Name".tr,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Enter the recipient’s Last Name".tr;
                  }
                  return null;
                },
                suffixIcon: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: CustomImage(
                      imageSrc: AppIcons.user,
                      imageType: ImageType.svg,
                      size: 24.h,
                    )),
              ),
              CustomText(
                  text: "Phone number".tr,
                  fontSize: 18.r,
                  bottom: 8.h,
                  style: true,
                  top: 24.h),
              Obx(
                () => CustomTextField(
                  fillColor: AppColors.gray80,
                  controller: AmountSendController.numberController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter phone number".tr;
                    }
                    return null;
                  },
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: CustomImage(
                      imageSrc: AppIcons.contact,
                      imageType: ImageType.png,
                      size: 16.sp,
                    ),
                  ),
                  prefixSvgIcon: CustomText(
                      text: AmountSendController.countryCode.value,
                      color: AppColors.black50,
                      top: 16.h,
                      left: 8.w,
                      right: 4.w,
                      bottom: 14.h,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                      titleText: "Continue".tr,
                      buttonRadius: 50.r,
                      buttonHeight: 56,
                      buttonWidth: 155.w,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AmountSendController.amountController.clear();
                          AmountSendController.receiveController.clear();

                          Get.toNamed(AppRoute.amountSend);
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
