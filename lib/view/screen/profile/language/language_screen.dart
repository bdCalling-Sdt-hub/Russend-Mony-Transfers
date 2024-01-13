import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    List<String> language = ["English", "Francais"];

    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Language".tr, fontSize: 24.sp, bottom: 42.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "English".tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                  CustomImage(imageSrc: AppIcons.success, size: 18.h),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Francais".tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
