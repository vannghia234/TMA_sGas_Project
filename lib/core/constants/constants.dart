import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:sgas/core/constants/image_path.dart';

double getHeightScreen(context) => MediaQuery.of(context).size.height;
double getWidthScreen(context) => MediaQuery.of(context).size.width;

const header = {"Content-Type": "application/json"};

RegExp phoneNumberRegex = RegExp(r'^[0-9]{10,11}$');

var logger = Logger();

void showAnimationLoading(context) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: LottieBuilder.asset(
        ImagePath.loadingLotties,
        height: 95,
      ),
    ),
  );
}
