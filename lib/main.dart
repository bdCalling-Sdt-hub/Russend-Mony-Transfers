import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/core/app_route/app_route.dart';
import 'package:money_transfers/utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.noTransition,
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
