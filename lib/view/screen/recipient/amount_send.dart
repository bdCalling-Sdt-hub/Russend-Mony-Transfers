import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/view/screen/recipient/bottom_sheet/make_payment.dart';
import 'package:money_transfers/view/widgets/keyboard/custom_keyboard.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/back/back.dart';
import '../../widgets/custom_button/custom_button.dart';

class AmountSendScreen extends StatelessWidget {
  AmountSendScreen({super.key});

  MakePayment makePayment = MakePayment();

  AmountSendController amountSendController = Get.put(AmountSendController());

  RxBool isPay = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const Back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    text: "You pay".tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "Recipient gets".tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black75,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: true,
                    onChanged: (amount) {
                      print(amount);
                      amountSendController.youPay(amount);
                    },
                    onTap: () => isPay.value = true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: amountSendController.amountController,
                    decoration: InputDecoration(
                        hintText: "0",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: TextStyle(
                          fontSize: 32.sp,
                          color: AppColors.primaryColor,
                        )),
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (amount) {
                      amountSendController.receiveAmount(amount);
                      print(amount);
                    },
                    onTap: () => isPay.value = false,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: amountSendController.receiveController,
                    decoration: InputDecoration(
                        hintText: "0",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: TextStyle(
                          fontSize: 32.sp,
                          color: AppColors.black100,
                        )),
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: AppColors.black100,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: CustomText(
                    text: "RUB".tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "XAF".tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black75,
                  ),
                )
              ],
            ),
            const Spacer(),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: "Fee".tr,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black50,
                ),
                CustomText(
                  text: "0.00 RUB".tr,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(
                  text: "Should arrive".tr,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black50,
                ),
                CustomText(
                  text: "In a few minutes".tr,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )
              ],
            ),
            const Divider(),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => CustomKeyboard(
                  isPoint: true,
                  controller: isPay.value
                      ? amountSendController.amountController
                      : amountSendController.receiveController),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                onPressed: () {
                  makePayment.makePaymentSheet(context);
                },
                titleText: 'Continue'.tr,
                titleSize: 14.sp,
                buttonWidth: 155.w,
                buttonRadius: 50.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
