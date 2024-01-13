import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:money_transfers/controller/enter_passcode_controller.dart';
import 'package:money_transfers/controller/keyboard_controller.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../controller/local_auth/local_auth_controller.dart';
import '../../../core/app_route/app_route.dart';
import '../../widgets/keyboard/custom_keyboard.dart';

class EnterPasscodeScreen extends StatefulWidget {
  EnterPasscodeScreen({super.key});

  @override
  State<EnterPasscodeScreen> createState() => _EnterPasscodeScreenState();
}

class _EnterPasscodeScreenState extends State<EnterPasscodeScreen> {
  KeyboardController keyboardController = Get.put(KeyboardController());

  EnterPasscodeController enterPasscodeController =
      Get.put(EnterPasscodeController());

  LocalAuthController localAuthController = Get.put(LocalAuthController());
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          localAuthController.supportState =
              isSupported ? SupportState.supported : SupportState.unsupported;

          localAuthController.authenticateWithBiometrics(mounted);
        }));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Enter your passcode".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  bottom: 24.h,
                  top: 100.h,
                ),
                Flexible(
                  flex: 0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                    child: PinCodeTextField(
                      controller: enterPasscodeController.controller,
                      cursorColor: AppColors.black100,
                      obscureText: true,
                      enablePinAutofill: true,
                      obscuringCharacter: "*",
                      // controller: controller.otpController,
                      appContext: (context),

                      validator: (value) {
                        if (value!.length != 4) {
                          return null;
                        } else {
                          // return "Please enter passcode".tr;
                        }
                      },
                      autoFocus: true,
                      showCursor: false,
                      onChanged: (controllerLength) {
                        if (controllerLength.length == 4) {
                          Get.toNamed(AppRoute.welcomeScreen);
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 12.h,
                        fieldWidth: 12.w,
                        activeFillColor: Colors.black,
                        selectedFillColor: AppColors.transparentColor,
                        inactiveFillColor: AppColors.transparentColor,
                        borderWidth: 0.0.w,
                        errorBorderColor: AppColors.primaryColor,
                        selectedColor: AppColors.black100,
                        activeColor: AppColors.transparentColor,
                        inactiveColor: AppColors.black100,
                      ),
                      length: 4,
                      keyboardType: TextInputType.none,
                      enableActiveFill: true,
                    ),
                  ),
                ),
                const Spacer(),
                CustomKeyboard(
                  controller: enterPasscodeController.controller,
                  isForgot: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
