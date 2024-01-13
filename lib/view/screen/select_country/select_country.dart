import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/amoun_send_controller.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/screen/select_country/inner_widget/list_item.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../controller/recipent_information_controller.dart';
import '../../../core/app_route/app_route.dart';

class SelectCountry extends StatelessWidget {
  SelectCountry({super.key});

  RecipientInformationController recipientInformationController = Get.put(RecipientInformationController()) ;

  AmountSendController amountSendController = Get.put(AmountSendController()) ;


  List countryList = [
    {
      "name": "Cameroon",
      "countryToken": "XAF",
      "flag": AppIcons.cameroon,
      "isPay": "Cameroon",
      "countryCode": "+237",
    },
    {
      "name": "Central African R",
      "countryToken": "XAF",
      "flag": AppIcons.centralAfrican,
      "isPay": "available",
      "countryCode": "+236",

    },
    {
      "name": "Chad",
      "countryToken": "XAF",
      "flag": AppIcons.chad,
      "isPay": "available",
      "countryCode": "+235",

    },
    {
      "name": "Republic of Congo",
      "countryToken": "XAF",
      "flag": AppIcons.congo,
      "isPay": "available",
      "countryCode": "+243",


    },
    {
      "name": "Equatorial Guinea",
      "countryToken": "XAF",
      "flag": AppIcons.equatorialQuinea,
      "isPay": "available",
      "countryCode": "+240",

    },
    {
      "name": "Gabon",
      "countryToken": "XAF",
      "flag": AppIcons.gabon,
      "isPay": "available",
    "countryCode": "+241",

    },
    {
      "name": "Belarus",
      "countryToken": "BYN",
      "flag": AppIcons.belarus,
      "isPay": "Not available",
      "countryCode": "+375",

    },
    {
      "name": "Tajikistan",
      "countryToken": "TJS",
      "flag": AppIcons.tajikistan,
      "isPay": "Not available",
      "countryCode": "+992",

    },
    {
      "name": "Kazakhstan",
      "countryToken": "KZT",
      "flag": AppIcons.kazakhstan,
      "isPay": "Not available",
      "countryCode": "+7",

    },
  ];

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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: countryList.length,
                  itemBuilder: (context, index) {
                    var item = countryList[index];
                    return GestureDetector(


                      onTap: () {
                        recipientInformationController.numberPrefix.value = item['countryCode'] ;
                        amountSendController.exchangeRates() ;

                        if(item['isPay'] == "Cameroon") {
                          Get.toNamed(AppRoute.deliveryMethodCameroon) ;
                        }  else if(item['isPay'] == "available") {
                          Get.toNamed(AppRoute.moneyDeliveryMethod) ;
                        } else if(item['isPay'] == "Not available") {
                          Get.toNamed(AppRoute.moneyDeliveryResume) ;
                        }
                      },
                      // onTap: item['isPay']
                      //     ? () => Get.toNamed(AppRoute.moneyDeliveryMethod)
                      //     : () => Get.toNamed(AppRoute.moneyDeliveryResume),
                      child: ListItem(
                        countryName: item['name'],
                        countryToken: item['countryToken'],
                        flag: item['flag'],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
