import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Date Format Example'),
        ),
        body: Center(
          child: Text(
            "654465564",
            style: TextStyle(
                fontSize: 20,
              decoration: TextDecoration.none
            ),
          ),
        ),
      ),
    );
  }
}

