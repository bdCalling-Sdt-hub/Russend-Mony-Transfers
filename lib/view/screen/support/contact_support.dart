import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class ContactSupport extends StatelessWidget {
  const ContactSupport({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        extendBody: true,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 24.h),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomText(
                      text: "Contact Support".tr,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      bottom: 24.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 35.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor,width: 1.w,style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.white50
                          ),
                          child: CustomImage(imageSrc: AppIcons.whatsapp,size: 50.h),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 35.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor,width: 1.w,style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.white50
                          ),
                          child: CustomImage(imageSrc: AppIcons.email,size: 50.h),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              CustomText(text: "To help us serve you better, kindly have your transaction ID ready. This unique identifier can be found in your transaction located on your account dashboard.".tr,
                fontSize: 14.sp,color: AppColors.black50,maxLines: 5)
            ],
          ),
        ),
      ),
    );
  }
}
