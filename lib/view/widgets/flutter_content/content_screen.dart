import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:money_transfers/utils/app_colors.dart';

import 'flutter_content.dart';

class ContentScreen extends StatelessWidget {
  ContentScreen({super.key, required this.data});

  // @override
  bool isLoading = true;

  String data ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: CustomContainer(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Html(
                      data: data,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
