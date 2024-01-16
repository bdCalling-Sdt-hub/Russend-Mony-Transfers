import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/screen/passcode/enter_passcode_screen.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool switchOn = true;
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery
        .of(context)
        .size
        .width) / 393;
    var height = (MediaQuery
        .of(context)
        .size
        .height) / 852;

    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: "Security".tr, fontSize: 24.sp, bottom: 42.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: CustomText(
                              text: "Fingerprint/ Face id to unlock".tr,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              right: 24.w)),
                      // Container(
                      //   height: 40 * height,
                      //   width: 64 * width,
                      //   child: FittedBox(
                      //     fit: BoxFit.fill,
                      //     child: Switch(
                      //       value: switchOn,
                      //       activeColor: AppColors.primaryColor,
                      //       activeTrackColor: AppColors.primaryColor,
                      //       inactiveTrackColor: AppColors.black50,
                      //       thumbColor:
                      //           const MaterialStatePropertyAll(AppColors.white),
                      //       onChanged: (value) {
                      //         setState(() {
                      //           switchOn = value;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // ...
// ...
                      AdvancedSwitch(
                        controller: _controller,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.black50,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(100)),
                        width: 54.0,
                        height: 26.0,
                        enabled: true,
                        disabledOpacity: 0.5,
                      ),
                      // ...
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoute.changePasscode);
                    },
                    child: CustomText(
                        text: "Change passcode".tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        top: 12.h,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.snackbar("Log Out", "Log Out Successful");
                  Get.toNamed(AppRoute.logIn) ;
                },
                child: Row(
                  children: [
                    CustomImage(imageSrc: AppIcons.logOut, size: 18.h),
                    CustomText(
                        text: "Log out".tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor,
                        left: 10.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}