import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/controller/select_country_controller.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/screen/select_country/inner_widget/list_item.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../core/app_route/app_route.dart';

class SelectCountry extends StatefulWidget {
  SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  AmountSendController amountSendController = Get.put(AmountSendController());

  SelectCountryController selectCountryController =
      Get.put(SelectCountryController());

  @override
  void initState() {
    selectCountryController.allCountriesRepo();
    // TODO: implement initState
    super.initState();
  }

  // List countryList = [
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        /*appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),*/
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: "Select the recipient's country".tr,
                    fontSize: 26.sp,
                    maxLines: 2,
                    bottom: 24.h),
                Obx(() => selectCountryController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : selectCountryController.countryList == null
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectCountryController
                                .countryList!.data!.attributes!.length,
                            itemBuilder: (context, index) {
                              var item = selectCountryController
                                  .countryList!.data!.attributes![index];
                              return InkWell(
                                onTap: () {
                                  AmountSendController.countryCode.value =
                                      item.countryCode!;
                                  AmountSendController.countryFlag.value =
                                      item.countryFlag!;
                                  AmountSendController.countryName.value =
                                      item.name!;
                                  amountSendController.countryId.value =
                                      item.sId!;

                                  print("item.name ${item.name!}");

                                  if (item.isPaymentAvailable!) {
                                    if (item.paymentGateways!.length == 2) {
                                      Get.toNamed(
                                          AppRoute.deliveryMethodCameroon);
                                    } else {
                                      Get.toNamed(AppRoute.moneyDeliveryMethod);
                                    }
                                  } else {
                                    Get.toNamed(AppRoute.moneyDeliveryResume);
                                  }
                                },
                                child: ListItem(
                                  countryName: item.name!,
                                  countryToken: item.currency!,
                                  flag: item.countryFlag!,
                                ),
                              );
                            },
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
