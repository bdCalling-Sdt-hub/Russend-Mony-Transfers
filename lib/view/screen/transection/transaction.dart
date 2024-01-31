import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/controller/enter_passcode_controller.dart';
import 'package:money_transfers/controller/transaction_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/services/socket_services.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TransactionController transactionController =
      Get.put(TransactionController());

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  EnterPasscodeController enterPasscodeController =
      Get.put(EnterPasscodeController());

  SocketServices socketServices = SocketServices();
  AmountSendController amountSendController = Get.put(AmountSendController());

  @override
  void initState() {
    sharedPreferenceHelper.getSharedPreferenceData();

    Timer(const Duration(seconds: 3), () {
      socketServices.connectToSocket();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.notification),
                  child: CustomImage(imageSrc: AppIcons.bell, size: 24.h)),
              GestureDetector(
                  onTap: () => Get.toNamed(AppRoute.profile),
                  child: CustomImage(imageSrc: AppIcons.profile, size: 24.h)),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: "Recent transaction".tr, fontSize: 26.sp),
              Obx(() => AmountSendController.isCancelled.value
                  ? Container(
                      height: 120,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 16.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.primaryColor,
                            width: 1.w,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.white50,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Cancelled Transaction".tr,
                              fontSize: 16.sp,
                            ),
                            Row(
                              children: [
                                SvgPicture.network(
                                  AmountSendController.countryFlag.value,
                                  height: 24.sp,
                                  width: 24.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                CustomText(
                                  text: AmountSendController.countryName.value,
                                  color: AppColors.black50,
                                )
                              ],
                            ),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: amountSendController.isRepeat.value
                                      ? "To Mobile: ${AmountSendController.numberController.text}"
                                      : "To Mobile: ${AmountSendController.countryCode.value}${AmountSendController.numberController.text}",
                                  color: AppColors.black50,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                CustomText(
                                  text: transactionController.currentDate(),
                                  color: AppColors.black50,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()),
              CustomText(
                text: transactionController.formattedDate(),
                // Use the formatted date here
                fontSize: 16.sp,
                color: AppColors.black50,
                top: 16.h,
                bottom: 12.h,
              ),
              Expanded(
                child: Obx(() => transactionController.loading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Obx(() => transactionController.transactionList.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              CustomText(
                                text: "You have no recent transaction".tr,
                                maxLines: 2,
                                fontSize: 20.sp,
                                color: AppColors.black50,
                              ),
                            ],
                          )
                        : ListView.builder(
                          controller:
                              transactionController.scrollController,
                          itemCount:
                              transactionController.isMoreLoading.value
                                  ? transactionController
                                          .transactionList.length +
                                      1
                                  : transactionController
                                      .transactionList.length,
                          itemBuilder: (context, index) {
                            if (index <
                                transactionController
                                    .transactionList.length) {
                              var transactionModel = transactionController
                                  .transactionList[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 24.h),
                                child: InkWell(
                                  onTap: () {
                                    transactionController
                                        .transactionDetailsRepo(
                                            SharedPreferenceHelper
                                                .accessToken,
                                            transactionModel.sId!);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 50.w,
                                            padding: EdgeInsets.all(4.h),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .primaryColor,
                                                    width: 1.w,
                                                    style:
                                                        BorderStyle.solid),
                                                shape: BoxShape.circle,
                                                color: AppColors.gray20),
                                            child: const CustomImage(
                                                imageSrc: AppIcons.arrow),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Container(
                                              height: 15.h,
                                              width: 15.w,
                                              decoration:
                                                  const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.network(
                                                  "${transactionModel.country!.countryFlag}",
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 8.w),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                    child: CustomText(
                                                        text:
                                                            "${transactionModel.firstName} ${transactionModel.lastName}",
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        right: 24.h,
                                                        textAlign: TextAlign
                                                            .start)),
                                                CustomText(
                                                    text:
                                                        "${transactionModel.amountToSent} ${transactionModel.amountToReceiveCurrency}",
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ],
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                CustomText(
                                                    text:
                                                        "To mobile : ${transactionModel.phoneNumber}",
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        AppColors.black50,
                                                    textAlign:
                                                        TextAlign.start),
                                                transactionModel.status ==
                                                        "pending"
                                                    ? CustomImage(
                                                        imageType:
                                                            ImageType.png,
                                                        imageSrc: AppIcons
                                                            .loadingIcon,
                                                        size: 20.h,
                                                        imageColor: AppColors
                                                            .black100)
                                                    : transactionModel.status ==
                                                            "cancelled"
                                                        ? CustomImage(
                                                            imageSrc: AppIcons
                                                                .cancelled,
                                                            size: 20.h,
                                                            imageColor:
                                                                AppColors
                                                                    .black100)
                                                        : transactionModel
                                                                    .status ==
                                                                "transferred"
                                                            ? CustomImage(
                                                                imageSrc: AppIcons
                                                                    .success,
                                                                size: 20.h,
                                                                imageColor:
                                                                    AppColors
                                                                        .black100)
                                                            : CustomImage(
                                                                imageSrc: AppIcons
                                                                    .transferred,
                                                                imageType:
                                                                    ImageType
                                                                        .png,
                                                                size: 20.h,
                                                                imageColor:
                                                                    AppColors
                                                                        .black100),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ))),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 24.h, left: 20.w, right: 20.w),
          child: CustomButton(
            titleText: "Send".tr,
            buttonRadius: 25.r,
            onPressed: () {
              AmountSendController.isCancelled.value = false ;
              amountSendController.isRepeat.value = false ;
              AmountSendController.numberController.text ="" ;
              Get.toNamed(AppRoute.selectCountry) ;
            }
          ),
        ),
      ),
    );
  }
}
