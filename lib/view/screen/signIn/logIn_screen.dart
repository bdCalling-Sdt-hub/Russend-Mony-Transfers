import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/sign_in_controller.dart';
import 'package:money_transfers/view/widgets/loading_container/loading_container.dart';

import '../../../core/app_route/app_route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/custom_button/custom_button.dart';
import '../../widgets/image/custom_image.dart';
import '../../widgets/text/custom_text.dart';
import 'inner_widget/logIn_filed.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final formKey = GlobalKey<FormState>();

  SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: CustomImage(
              imageSrc: AppIcons.language,
              imageColor: AppColors.black100,
              size: 20.sp),
        ),
        title: CustomText(
            text: "English".tr, fontSize: 20.sp, fontWeight: FontWeight.w400),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LogInFiled(),
                  Column(
                    children: [
                      Obx(
                        () => Center(
                          child: signInController.isLoading.value
                              ? LoadingContainer()
                              : CustomButton(
                                  titleText: "Log in".tr,
                                  buttonRadius: 12.r,
                                  buttonWidth: double.infinity,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      signInController.signInRepo();
                                    }
                                  }),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don’t have an account? ".tr,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          GestureDetector(
                              onTap: () => Get.toNamed(AppRoute.createAccount),
                              child: CustomText(
                                text: "Sign up".tr,
                                fontSize: 15.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
