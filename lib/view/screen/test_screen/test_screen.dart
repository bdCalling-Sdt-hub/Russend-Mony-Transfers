import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();

    print(date.timeZoneName);
    print(date);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Date Format Example'),
        ),
        body: Center(
          child: Text(
            formattedLocalDuration("04:51:00.0000"),
            style: TextStyle(fontSize: 20, decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }

  String formattedLocalDuration(String globalTime) {
    List<String> parts = globalTime.split(':');
    Duration duration = Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
      seconds: int.parse(
          parts[2].split('.')[0]), // Extract seconds without milliseconds
    );

    // Apply the time zone offset
    String timeZone = DateTime.now().timeZoneName;

    int timeZoneHour = 0;
    int timeZoneMinutes = 0;

    if (timeZone.contains(":")) {
      timeZoneHour = int.parse(timeZone.split(":")[0]);
      timeZoneMinutes = int.parse(timeZone.split(":")[1]);
    } else {
      timeZoneHour = int.parse(timeZone);
    }

    duration = duration + Duration(hours: timeZoneHour);

    // Format the duration as needed with AM/PM
    String period = duration.inHours >= 12 ? 'PM' : 'AM';
    int formattedHours =
        duration.inHours % 12 == 0 ? 12 : duration.inHours % 12;
    String formattedDuration =
        "$formattedHours:${(duration.inMinutes % 60).toString().padLeft(2, '0')} $period";

    return formattedDuration;
  }
}
