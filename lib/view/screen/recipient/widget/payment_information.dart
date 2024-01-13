import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/text/custom_text.dart';

class PaymentInformation extends StatelessWidget {
  PaymentInformation({super.key});

  String receiverName = "ричард манни в";

  String amountRub = "1500 RUB";
  String paymentId = "Сбербанк (sberbank)";
  String number = "+79050048977";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Payment Information".tr,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            bottom: 8.h,
          ),
          Row(
            children: [
              CustomText(
                text: "Bank :".tr,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black100,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: paymentId,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black100,
                textAlign: TextAlign.start,
                bottom: 15.h,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: "Phone Number :".tr,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black100,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: number,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black100,
                textAlign: TextAlign.start,
                bottom: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  final value = ClipboardData(text: number) ;
                  Clipboard.setData(value) ;
                  Get.snackbar("Copy", "Copied to Clipboard") ;
                },
                  child: SvgPicture.asset(AppIcons.copy))
            ],
          ),
          Row(
            children: [
              CustomText(
                text: "Name :".tr,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black100,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: receiverName,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black100,
                textAlign: TextAlign.start,
                bottom: 15.h,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: "Amount to send :".tr,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.black100,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            children: [
              CustomText(
                text: amountRub,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
