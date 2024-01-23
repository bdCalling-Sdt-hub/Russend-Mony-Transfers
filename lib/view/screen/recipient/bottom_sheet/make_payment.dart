import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/screen/recipient/widget/rich_text.dart';

import '../../../widgets/custom_button/custom_button.dart';
import '../../../widgets/text/custom_text.dart';

class MakePayment {
  makePaymentSheet(BuildContext context) {

    AmountSendController amountSendController = Get.put(AmountSendController()) ;

    return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    CustomText(
                      textAlign: TextAlign.center,
                      text: "Important".tr,
                      fontSize: 20.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          AppIcons.cancel,
                          color: Colors.black,
                          height: 16.h,
                          width: 16.w,
                        ))
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomText(
                  text: "1-You can make the payment from any russian bank".tr,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  fontSize: 18.sp,
                ),
                SizedBox(
                  height: 16.h,
                ),
                RichTextWidget(
                    firstText: "2-You will get ".tr,
                    secondText: "10 minutes".tr,
                    thirdText: " to make the payment".tr),
                SizedBox(
                  height: 16.h,
                ),
                RichTextWidget(
                    firstText: "3-If after ".tr,
                    secondText: "10 minutes".tr,
                    thirdText:
                        " the payment has not been made, the transaction will be automatically canceled"
                            .tr),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                  child: CustomButton(
                      titleText: "Make payment".tr,
                      buttonRadius: 50.r,
                      buttonHeight: 50.h,
                      titleSize: 24.sp,
                      buttonWidth: double.infinity,
                      onPressed: () {
                        amountSendController.paymentInfoRepo() ;
                        // Get.toNamed(AppRoute.paymentMethodFinal);
                      }),
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
