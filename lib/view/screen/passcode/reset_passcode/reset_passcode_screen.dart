import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/back/back.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            CustomText(
              text: "Reset your passcode by logging in again".tr,
              fontSize: 24.sp,
              maxLines: 3,
              top: 16.h,
              bottom: 100.h,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();

                pref.setString("email", "");
                pref.setString("accessToken", "");
                pref.setString("refreshToken", "");
                pref.setBool("isLogIn", false);
                pref.setBool("isLocalAuth", false);
                Get.toNamed(AppRoute.logIn);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomImage(imageSrc: AppIcons.logOut),
                  CustomText(
                    text: "Log out".tr,
                    fontSize: 24.sp,
                    left: 16.w,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
