import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

import '../../../utils/app_colors.dart';

class RowText extends StatelessWidget {

  const RowText({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: title.tr,color: AppColors.black50,fontSize: 18.sp,fontWeight: FontWeight.w400,right: 24.w),
        Flexible(child: CustomText(text: value.tr,fontSize: 18.sp,fontWeight: FontWeight.w400,right: 4.w,maxLines: 1)),
      ],
    );
  }
}
