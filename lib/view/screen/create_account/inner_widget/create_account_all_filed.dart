import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:money_transfers/utils/app_colors.dart';

import '../../../../controller/sign_up/sign_up_controller.dart';
import '../../../../utils/app_icons.dart';
import '../../../widgets/custom_text_field/custom_text_field.dart';
import '../../../widgets/image/custom_image.dart';
import '../../../widgets/text/custom_text.dart';

class CreateAccountAllFiled extends StatelessWidget {
  CreateAccountAllFiled({super.key});

  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var h = height / 852;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4 * h),
          child: Text(
            "Full Name".tr,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CustomTextField(
          hintText: "Enter your Full Name".tr,
          paddingHorizontal: 24.w,
          controller: signUpController.nameController,
          paddingVertical: 14 * h,
          fillColor: AppColors.gray80,
          validator: (value) {
            if (value.isEmpty) {
              return "Enter your Full Name".tr;
            }
          },
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: const CustomImage(
              imageSrc: AppIcons.user,
              imageType: ImageType.svg,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16 * h, bottom: 4 * h),
          child: Text(
            "Email".tr,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CustomTextField(
          hintText: "Enter a valid email".tr,
          controller: signUpController.emailController,
          paddingHorizontal: 24.w,
          paddingVertical: 14 * h,
          fillColor: AppColors.gray80,
          validator: (value) {
            if (value.contains("@")) {
              return null;
            } else {
              return "Enter a valid email".tr;
            }
          },
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: const CustomImage(
              imageSrc: AppIcons.mail,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16 * h, bottom: 4 * h),
          child: Text(
            "Phone Number".tr,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        IntlPhoneField(
          controller: signUpController.numberController,
          validator: (value) {
            if (value!.number.isEmpty) {
              return "Invalid Mobile Number".tr;
            }
          },
          decoration: InputDecoration(
            hintText: "Mobile number".tr,
            fillColor: AppColors.gray80,
            filled: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 4.w, vertical: 14 * h),
            border: const OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
          initialCountryCode: "CM",
          disableLengthCheck: false,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 4 * h),
          child: Text(
            "Password".tr,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CustomTextField(
          hintText: "Password".tr,
          controller: signUpController.passwordController,
          paddingHorizontal: 24.w,
          paddingVertical: 14 * h,
          validator: (value) {
            return signUpController.validatePassword(value) ;
          },
          fillColor: AppColors.gray80,
          isPassword: true,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16 * h, bottom: 4 * h),
          child: Text(
            "ConfirmPassword".tr,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        CustomTextField(
          hintText: "ConfirmPassword".tr,
          paddingHorizontal: 24.w,
          controller: signUpController.confirmPasswordController,
          paddingVertical: 14 * h,
          fillColor: AppColors.gray80,
          validator: (value) {
            if (signUpController.passwordController.text ==
                    signUpController.confirmPasswordController.text &&
                value.isNotEmpty) {
              return null;
            } else {
              return "The password does not match".tr;
            }
          },
          isPassword: true,
        ),
        SizedBox(
          height: 16 * h,
        ),
      ],
    );
  }
}
