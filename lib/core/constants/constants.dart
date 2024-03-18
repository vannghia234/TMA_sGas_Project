import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

double getHeightScreen(context) => MediaQuery.of(context).size.height;
double getWidthScreen(context) => MediaQuery.of(context).size.width;

const header = {"Content-Type": "application/json"};

RegExp phoneNumberRegex = RegExp(r'^[0-9]{10,11}$');

var logger = Logger();
