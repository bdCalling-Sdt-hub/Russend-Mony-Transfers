import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/screen/notification/inner_widget/list_item.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class Notification extends StatelessWidget {
  Notification({super.key});

  List notificationList = [
    {
      "title": "Your account has been verified",
      "time": "20 minutes ago",
    },
    {
      "title": "You have received \$750 from Jane",
      "time": "20 minutes ago",
    },
    {
      "title": "You have sent \$750 to Jane",
      "time": "20 minutes ago",
    },
    {
      "title": "You have sent \$750 to Jane",
      "time": "20 minutes ago",
    },


  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
            appBarContent: Back(
          onTap: () => Get.back(),
          text: "Notification".tr,
        )),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notificationList.length,
            itemBuilder: (context, index) {

              var item = notificationList[index] ;
              return ListItem(
                title: item['title'],
                time: item['time'],

              );
            },
          ),
        ),
      ),
    );
  }
}
