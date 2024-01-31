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

class TransactionCancelScreen extends StatelessWidget {
  TransactionCancelScreen({super.key});

  AmountSendController amountSendController = Get.put(AmountSendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.gray,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    AmountSendController.isCancelled.value = true ;
                    Get.offAllNamed(AppRoute.transaction);
                    AmountSendController.amountController.clear();
                    AmountSendController.receiveController.clear();
                    AmountSendController.firstNameController.clear();
                    AmountSendController.lastNameController.clear();
                  },
                  child: CustomText(
                    text: "Continue".tr,
                    fontSize: 20,
                    bottom: 7.h,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.right,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomImage(imageSrc: AppIcons.cancel),
                    CustomText(
                      text: "Your  order has been cancelled".tr,
                      fontSize: 20,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextRichWidget(
                      firstText:
                      "If you believe your transaction was canceled by mistake, please "
                          .tr,
                        secondText: "${AmountSendController.firstNameController.text} ${AmountSendController.lastNameController.text}"

                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SuccessfulItem(
                      title: "Amount Sent".tr,
                      service: "${AmountSendController.amountController.text} RUB",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SuccessfulItem(
                      title: "Fee".tr,
                      service: "0.00 RUB",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SuccessfulItem(
                        title: "You pay".tr,
                        service: "${AmountSendController.amountController.text} RUB",
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor),
                    const SizedBox(
                      height: 8,
                    ),
                    SuccessfulItem(
                      title: "Amount Received".tr,
                      service: "${AmountSendController.receiveController.text} ${"XAF".tr}",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SuccessfulItem(
                      title: "Should Arrive".tr,
                      service: "Cancelled".tr,
                      color: AppColors.redMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: "Important!".tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
            TextRichWidget(
              secondText: "contact us".tr,
              firstText:
                  "If you believe your transaction was canceled by mistake"
                      .tr,
              secondColor: AppColors.primaryColor,
              alignment: TextAlign.start,
              firstColor: Colors.white,
              horizontal: 0,
            )
          ],
        ),
      )),
    );
  }
}
