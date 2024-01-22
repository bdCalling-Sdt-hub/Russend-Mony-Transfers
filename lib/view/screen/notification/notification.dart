import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:money_transfers/controller/notification_controller.dart';
import 'package:money_transfers/utils/app_colors.dart';
import 'package:money_transfers/view/screen/notification/inner_widget/list_item.dart';
import 'package:money_transfers/view/widgets/app_bar/custom_app_bar.dart';
import 'package:money_transfers/view/widgets/back/back.dart';
import 'package:money_transfers/view/widgets/text/custom_text.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  // List notificationList = [
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.getIsisLogIn();
  }

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
          body: Obx(
            () => notificationController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, bottom: 24.h),
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          notificationController.notificationModelInfo != null
                              ? notificationController.notificationModelInfo!
                                  .data!.attributes!.notificationList!.length
                              : 0,
                      itemBuilder: (context, index) {
                        var item = notificationController.notificationModelInfo!
                            .data!.attributes!.notificationList![index];
                        var createdAtTime = item.createdAt!.split(".")[0];
                        var date = createdAtTime.split("T")[0];
                        var time = createdAtTime.split("T")[1];
                        return ListItem(
                          title: item.message!,
                          time: "$date at $time",
                        );
                      },
                    ),
                  ),
          )),
    );
  }
}
