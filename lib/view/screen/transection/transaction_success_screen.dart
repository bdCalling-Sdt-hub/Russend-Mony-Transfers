import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/rich_text/rich_text.dart';
import 'package:money_transfers/view/screen/transection/widget/successful_item.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../core/app_route/app_route.dart';

class TransactionSuccessScreen extends StatelessWidget {
  TransactionSuccessScreen({super.key});

  AmountSendController amountSendController = Get.put(AmountSendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(AppRoute.transaction);
                  amountSendController.amountController.clear();
                  amountSendController.receiveController.clear();
                  amountSendController.firstNameController.clear();
                  amountSendController.lastNameController.clear();
                  amountSendController.numberController.clear();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    text: "Continue".tr,
                    fontSize: 20.sp,
                    bottom: 7.h,
                    top: 16.h,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.right,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomImage(
                        imageSrc: AppIcons.success,
                        size: 110.sp,
                      ),
                      CustomText(
                        text: "Your  order has been received".tr,
                        fontSize: 20.sp,
                        top: 30.h,
                        bottom: 12.h,
                      ),
                      TextRichWidget(
                          secondText:
                              "${amountSendController.firstNameController.text} ${amountSendController.lastNameController.text}",
                          firstText: "Mobile Money Transfer for ".tr),
                      SizedBox(
                        height: 16.h,
                      ),
                      SuccessfulItem(
                        title: "Amount Sent".tr,
                        service:
                            "${amountSendController.amountController.text} ${amountSendController.amountToSentCurrency}",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SuccessfulItem(
                        title: "Fee".tr,
                        service: "0.00 RUB",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SuccessfulItem(
                          title: "You Pay".tr,
                          service:
                              "${amountSendController.amountController.text} ${amountSendController.amountToSentCurrency}",
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                      SizedBox(
                        height: 8.h,
                      ),
                      SuccessfulItem(
                        title: "Amount Received".tr,
                        service:
                            "${amountSendController.receiveController.text} ${amountSendController.amountToReceiveCurrency}",
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SuccessfulItem(
                        title: "Should Arrive".tr,
                        service: "In a few minutes",
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Important!".tr,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ],
              ),
              CustomText(
                  text:
                      "Your transaction will be available within 2 to 3 hours or sooner (It usually takes few minutes). We will send you a notification when the funds are available"
                          .tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  maxLines: 6,
                  textAlign: TextAlign.start),
            ],
          ),
        ),
      )),
    );
  }
}
