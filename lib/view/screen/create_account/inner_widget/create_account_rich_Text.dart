import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_transfers/utils/app_colors.dart';

class CreateAccountTermsConditions extends StatelessWidget {
  const CreateAccountTermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'By signing up you agree to our ',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.black100,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Terms',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ' and ',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.black100,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: 'Conditions',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: '.',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.black100,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
