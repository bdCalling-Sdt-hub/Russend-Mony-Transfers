import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/screen/recipient/widget/appbar_rich_text.dart';
import 'package:money_transfers/view/screen/recipient/widget/payment_information.dart';
import 'package:money_transfers/view/screen/recipient/widget/rich_text.dart';

import '../../../core/app_route/app_route.dart';
import '../../widgets/custom_button/custom_button.dart';
import '../../widgets/image/custom_image.dart';

class PaymentMethodFinal extends StatelessWidget {
  PaymentMethodFinal({super.key});

  String name = "Cedric william";
  String receiverName = "ричард манни в";

  String amount = "12350 XAF ";
  String amountRub = "1500 RUB";
  String paymentId = "Сбербанк (sberbank)";
  String number = "+79050048977";
  String time = "9 : 25";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: PaymentTextRich(
          firstText: "Transfer of ".tr,
          secondText: amount,
          thirdText: "to ".tr,
          fourText: name,
          fontSize: 20.sp,
        ),
        actions: [
          SizedBox(width: 60.w,)
        ],
        centerTitle: true,
        leadingWidth: 55.w,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            margin: EdgeInsets.only(left: 20.w),
            decoration: const BoxDecoration(
                color: AppColors.black100, shape: BoxShape.circle),
            child: const CustomImage(
              imageSrc: AppIcons.arrowBackIos,
              size: 18,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PaymentTextRich(
                firstText:
                    "To make the payment you should log in your bank app (sberbank online) and send "
                        .tr,
                secondText: amountRub,
                thirdText:
                    " to the phone number displayed below. After sending the money, click on "
                        .tr,
                fourText: "I made the payment".tr,
                maxLines: 6,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.w, color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: PaymentInformation(),
              ),
              SizedBox(
                height: 24.h,
              ),
              RichTextWidget(
                firstText: "You have ".tr,
                secondColor: AppColors.redDark,
                secondText: time,
                thirdText: " left to make the payment".tr,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8.h,
              ),
              CustomButton(
                  titleText: "I Made the payment".tr,
                  buttonRadius: 20.r,
                  titleColor: AppColors.white85,
                  buttonWidth: double.infinity,
                  titleSize: 24.sp,
                  onPressed: () {
                    Get.toNamed(AppRoute.transactionSuccessScreen);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
