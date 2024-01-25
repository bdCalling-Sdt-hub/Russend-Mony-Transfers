import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/personal_info_controller.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/utils/app_icons.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/image/custom_image.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getIsisLogIn();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getIsisLogIn() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
      sharedPreferenceHelper.accessToken = pref.getString("accessToken") ?? "";
      sharedPreferenceHelper.id = pref.getString("id") ?? "";
      sharedPreferenceHelper.isLogIn = pref.getBool("isLogIn") ?? false;
      print(
          "Personal Info  ====================================> ${sharedPreferenceHelper.accessToken.toString()}");

      personalInfoController.userDetailsRepo(
          sharedPreferenceHelper.accessToken, sharedPreferenceHelper.id);
    } catch (e) {
      print(e.toString());
    }
  }

  PersonalInfoController personalInfoController =
      Get.put(PersonalInfoController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(appBarContent: Back(onTap: () => Get.back())),
        body: Obx(() => personalInfoController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 75.h,
                        width: 75.w,
                        decoration: BoxDecoration(
                          color: AppColors.white50,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.primaryColor, width: 0.5.w),
                        ),
                        child: Center(
                            child: CustomText(
                                text: personalInfoController
                                    .userDetailsModelInfo
                                    ?.data
                                    ?.attributes
                                    ?.fullName?[0] ??
                                    "U",
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w400)),
                      ),
                      CustomText(
                          text: personalInfoController.userDetailsModelInfo
                              ?.data?.attributes?.fullName ??
                              "User",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          top: 16.h,
                          bottom: 24.h),
                      Divider(height: 1.h, color: AppColors.black50),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: personalInfoController.profile.length,
                        itemBuilder: (context, index) {
                          var profile = personalInfoController.profile ;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (profile[index]["title"] ==
                                      "Personal info".tr) {
                                    Get.toNamed(AppRoute.profileInfo);
                                  } else if (profile[index]["title"] ==
                                      "Security".tr) {
                                    Get.toNamed(AppRoute.securityScreen);
                                  } else if (profile[index]["title"] ==
                                      "Language".tr) {
                                    Get.toNamed(AppRoute.languageScreen);
                                  }
                                  // else if(profile[index]["title"] == "Appearance".tr){
                                  //   Get.toNamed(AppRoute.appearanceScreen);
                                  // }
                                  else if (profile[index]["title"] ==
                                      "Legal".tr) {
                                    Get.toNamed(AppRoute.legalScreen);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 16.h),
                                  child: Row(
                                    children: [
                                      CustomImage(
                                          imageSrc: "${profile[index]["icon"]}",
                                          size: 28.h,
                                          imageColor: AppColors.primaryColor),
                                      CustomText(
                                          text: "${profile[index]["title"]}".tr,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w400,
                                          left: 16.w)
                                    ],
                                  ),
                                ),
                              ),
                              Divider(height: 1.h, color: AppColors.black50)
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 42.h),
                    ],
                  ),
                ),
              )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoute.contactSupport),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(imageSrc: AppIcons.support, size: 30.h),
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
      ),
    );
  }
}
