import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_route/app_route.dart';
import '../../../../utils/app_colors.dart';
import '../text/custom_text.dart';

class ResendRichText extends StatelessWidget {
  ResendRichText({
    super.key,
    required this.onTap
  });

  Function() onTap ;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Didn’t receive any code? ".tr,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.black100,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
              recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTap() ;
              },
              text: "Send Again".tr,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.primaryColor!,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ))
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
