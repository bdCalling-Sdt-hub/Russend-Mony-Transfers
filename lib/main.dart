import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/helper/shared_preference_helper.dart';
import 'package:money_transfers/laguages.dart';
import 'package:money_transfers/services/socket_services.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'services/notification_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SocketServices socketServices = SocketServices();
  NotificationService notificationService = NotificationService() ;
  SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper() ;
  notificationService.initLocalNotification() ;
  socketServices.connectToSocket();
  await sharedPreferenceHelper.getSharedPreferenceData() ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      designSize: const Size(393, 852),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.noTransition,
          locale: Locale(SharedPreferenceHelper.localizationLanguageCode, SharedPreferenceHelper.localizationCountryCode),
          fallbackLocale: const Locale("en", "US"),
          translations: Languages(),
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: AppColors.background,
          )),
          transitionDuration: const Duration(milliseconds: 200),
          initialRoute: AppRoute.splashScreen,
          navigatorKey: Get.key,
          getPages: AppRoute.routes,
        );
      },
    );
  }
}
