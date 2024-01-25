import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});

  final duration = const Duration(minutes: 10).obs;

  Timer? timer;
  RxString time = "0:09:13.000000".obs;

  startTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      const addSeconds = 1;
      final seconds = duration.value.inSeconds - addSeconds;
      duration.value = Duration(seconds: seconds);
      if (time.value != 0) {
        time.value = duration.toString();
      } else {
        timer?.cancel();
      }
    });
  }

  String formattedDuration() {
    // Parse the duration string
    List<String> parts = time.value.split(':');
    Duration duration = Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(
          parts[2].split('.')[0]), // Extract seconds without milliseconds
    );

    // Format the duration as needed
    String formattedDuration =
        "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";

    print(formattedDuration);

    return formattedDuration;
  }

  @override
  Widget build(BuildContext context) {
    startTime();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Obx(() => Text(formattedDuration(),
                style: const TextStyle(fontSize: 40))),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "name".tr,
              style: const TextStyle(fontSize: 40),
            ),
          )
        ],
      ),
    );
  }
}
