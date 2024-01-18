import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/enter_passcode_controller.dart';
import 'package:money_transfers/controller/transaction_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/models/transaction_model.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/enter_passcode_model.dart';

class Transaction extends StatefulWidget {
  Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TransactionController transactionController =
      Get.put(TransactionController());

  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();

  EnterPasscodeController enterPasscodeController =
      Get.put(EnterPasscodeController());

  @override
  void initState() {
    getIsisLogIn();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getIsisLogIn() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      sharedPreferenceHelper.accessToken =
          pref.getString("accessToken") ?? "aa";
      sharedPreferenceHelper.isLogIn = pref.getBool("isLogIn") ?? false;
      print(
          "Transaction ====================================> ${sharedPreferenceHelper.accessToken.toString()}");

      transactionController.transactionRepo(sharedPreferenceHelper.accessToken);
    } catch (e) {
      print(e.toString());
    }
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: "Recent transaction".tr, fontSize: 26.sp),
              CustomText(
                  text: "OCTOBER 2023".tr,
                  fontSize: 16.sp,
                  color: AppColors.black50,
                  top: 24.h,
                  bottom: 30.h),
              Obx(() => transactionController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactionController.isLoading.value
                          ? transactionController.transactionModelInfo!.data!
                                  .attributes!.transactionList!.length +
                              1
                          : transactionController.transactionModelInfo!.data!
                              .attributes!.transactionList!.length,
                      itemBuilder: (context, index) {
                        var transactionModel = transactionController
                            .transactionModelInfo!
                            .data!
                            .attributes!
                            .transactionList![index];

                        return Padding(
                          padding: EdgeInsets.only(bottom: 24.h),
                          child: InkWell(
                            onTap: () {
                              transactionController.transactionDetailsRepo(
                                  sharedPreferenceHelper.accessToken,
                                  transactionModel.sId!);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.w,
                                      padding: EdgeInsets.all(4.h),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 1.w,
                                              style: BorderStyle.solid),
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
                                        decoration: const BoxDecoration(
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
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              child: CustomText(
                                                  text:
                                                      "${transactionModel.firstName} ${transactionModel.lastName}",
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  right: 24.h,
                                                  textAlign: TextAlign.start)),
                                          CustomText(
                                              text:
                                                  "${transactionModel.amountToSent} ${transactionModel.amountToReceiveCurrency}",
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              text:
                                                  "To mobile : ${transactionModel.phoneNumber}",
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.black50,
                                              textAlign: TextAlign.start),
                                          Center(
                                            child: transactionModel.status == "pending"
                                                ? SizedBox(
                                              width: 12.w,
                                              height: 12.h,
                                              child: const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                                : transactionModel.status == "cancelled" ?
                                              CustomImage(
                                                imageSrc: AppIcons.cancelled,
                                                size: 20.h,
                                                imageColor: AppColors.black100)  :
                                            transactionModel.status == "transferred" ?
                                            CustomImage(
                                                imageSrc: AppIcons.success,
                                                size: 20.h,
                                                imageColor: AppColors.black100) :
                                            CustomImage(
                                                imageSrc: AppIcons.transferred,
                                                imageType: ImageType.png,
                                                size: 20.h,
                                                imageColor: AppColors.black100)
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ))
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: CustomButton(
            titleText: "Send".tr,
            buttonRadius: 25.r,
            onPressed: () => Get.toNamed(AppRoute.selectCountry),
          ),
        ),
      ),
    );
  }
}
