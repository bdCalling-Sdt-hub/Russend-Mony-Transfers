import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/custom_button/custom_button.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImage(imageSrc: AppIcons.language,imageColor: AppColors.black100,size: 30.h),
                  CustomText(text: "English".tr,fontSize: 20.sp,fontWeight: FontWeight.w400,left: 8.w)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(text: "Legal terms".tr,fontSize: 20.sp,fontWeight: FontWeight.w400,right: 4.w),
                  CustomImage(imageSrc: AppIcons.legalTerms,imageColor: AppColors.black100,size: 20.h)
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Get started with Russend".tr,fontSize: 20.sp,fontWeight: FontWeight.w600,bottom: 8.h),
              CustomText(text: "Insert your phone number to get the verification code".tr,fontSize: 18.sp,maxLines: 3,textAlign: TextAlign.start,color: AppColors.black40),
              SizedBox(height: 42.h),

              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: "Phone Number".tr,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                ),
                initialCountryCode: "BD",


              ),
              
            ],
          ),
        ),
        
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 24.h),
          child: CustomButton(titleText: "Continue".tr,buttonRadius: 50.r,titleSize: 14.sp,onPressed: () => Get.toNamed(AppRoute.signUpOtp),),
        ),
      ),
    );
  }
}
