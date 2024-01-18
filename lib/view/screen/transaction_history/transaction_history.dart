import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/controller/transaction_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/models/transaction_details_model.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/row_text/row_text.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class TransactionHistory extends StatelessWidget {
  TransactionHistory({super.key});

  AmountSendController amountSendController = Get.put(AmountSendController());

  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    var item =
        transactionController.transactionDetailsModelInfo!.data!.attributes;

    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 24.h),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 75.h,
                      width: 75.w,
                      padding: EdgeInsets.all(4.h),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1.w,
                              style: BorderStyle.solid),
                          shape: BoxShape.circle,
                          color: AppColors.gray20),
                      child: const CustomImage(imageSrc: AppIcons.arrow),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child:
                            SvgPicture.network("${item!.country!.countryFlag}"),
                      ),
                    ),
                  ],
                ),
                CustomText(
                    text: "${item!.sender!.fullName}",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    top: 8.h,
                    bottom: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                        text:
                            "${item.amountToSent} ${item.ammountToSentCurrency}",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        right: 4.w),
                    Icon(Icons.arrow_forward_outlined,
                        size: 18.h, color: AppColors.black100),
                    CustomText(
                        text:
                            "${item.amountToReceive} ${item.amountToReceiveCurrency}",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        left: 4.w),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: item.status == "pending"
                            ? SizedBox(
                                width: 12.w,
                                height: 12.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : item.status == "cancelled"
                                ? CustomImage(
                                    imageSrc: AppIcons.cancelled,
                                    size: 20.h,
                                    imageColor: AppColors.black100)
                                : item.status == "transferred"
                                    ? CustomImage(
                                        imageSrc: AppIcons.success,
                                        size: 20.h,
                                        imageColor: AppColors.black100)
                                    : CustomImage(
                                        imageSrc: AppIcons.transferred,
                                        imageType: ImageType.png,
                                        size: 20.h,
                                        imageColor: AppColors.black100)),
                    SizedBox(
                      width: 4.w,
                    ),
                    CustomText(
                        text: "${item.status}", fontSize: 18.sp, left: 4.w)
                  ],
                ),
                SizedBox(height: 24.h),
                Divider(height: 1.h, color: AppColors.black50),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 35.h,
                      width: 35.h,
                      margin: EdgeInsets.only(left: 20.w, right: 12.w),
                      padding: EdgeInsets.all(8.h),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor),
                      child: const CustomImage(imageSrc: AppIcons.reTry),
                    ),
                    GestureDetector(
                        onTap: () {
                          amountSendController.amountController.text = "1500";
                          Get.toNamed(AppRoute.amountSend);
                        },
                        child: CustomText(
                            text: "Repeat transfer".tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor))
                  ],
                ),
                SizedBox(height: 12.h),
                Divider(height: 1.h, color: AppColors.black50),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: "Transaction ID".tr,
                              color: AppColors.black50,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400),
                          Row(
                            children: [
                              CustomText(
                                  text: "64594544".tr,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  right: 4.w),
                              Icon(Icons.copy_rounded,
                                  size: 18.h, color: AppColors.black50)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      RowText(title: "Date".tr, value: "${item.createdAt}"),
                      SizedBox(height: 24.h),
                      RowText(title: "Rate".tr, value: "${item.exchangeRate}"),
                      SizedBox(height: 24.h),
                      RowText(
                          title: "Fee".tr,
                          value:
                              amountSendController.amountController.value.text),
                      SizedBox(height: 24.h),
                      RowText(
                          title: "Recipient".tr,
                          value: "${item.firstName} ${item.lastName}"),
                      SizedBox(height: 24.h),
                      RowText(
                          title: "Delivery".tr,
                          value: "To mobile: ${item.phoneNumber}"),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Divider(height: 1.h, color: AppColors.black50),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoute.contactSupport),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomImage(imageSrc: AppIcons.support, size: 35.h),
                        CustomText(
                            text: "Contact support".tr,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor,
                            left: 8.w)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
