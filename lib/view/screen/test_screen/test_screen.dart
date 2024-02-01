import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getFormattedDate();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Date Format Example'),
        ),
        body: Center(
          child: Text(
            getFormattedDate(),
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

 String getFormattedDate() {
  String dateString = "2024-02-01T04:39:03.524Z";
  DateTime originalDateTime = DateTime.parse(dateString);
  DateTime currentDateTime = DateTime.now();

  Duration difference = currentDateTime.difference(originalDateTime);

  return ("Time difference: ${difference.inDays} days, ${difference.inHours % 24} hours, ${difference.inMinutes % 60} minutes");
}
