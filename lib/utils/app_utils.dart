import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_transfers/utils/app_colors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  //
  // static toastMessage(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: AppColors.green,
  //     webBgColor: AppColors.black100,
  //     textColor: AppColors.white,
  //     gravity: ToastGravity.BOTTOM,
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  // }
  //
  // static toastMessageCenter(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: AppColors.green,
  //     gravity: ToastGravity.CENTER,
  //     toastLength: Toast.LENGTH_LONG,
  //     textColor: AppColors.white,
  //   );
  // }


}