import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:local_auth/local_auth.dart';
import 'package:money_transfers/core/app_route/app_route.dart';

class LocalAuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  RxBool canCheckBiometrics = false.obs;
  RxList availableBiometrics = [].obs;
  RxString authorized = 'Not Authorized'.obs;
  RxBool isAuthenticating = false.obs;




  Future<void> authenticateWithBiometrics(bool mounted) async {
    bool authenticated = false;
    try {
      print("object");
      isAuthenticating.value = true;
      authorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,


        ),
      );
      isAuthenticating.value = false;
      authorized.value = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);
      isAuthenticating.value = false;
      authorized.value = 'Error - ${e.message}';

      return;
    }
    if (!mounted) {
      return;
    }

     authenticated ? Get.toNamed(AppRoute.welcomeScreen) : const SizedBox();
    authorized.value = "message";
  }

}

enum SupportState {
  unknown,
  supported,
  unsupported,
}
