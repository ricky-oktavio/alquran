import 'package:flutter/material.dart';

const appGreenD = Colors.green;
const appGreenL = Colors.lightGreen;
const appWhite = Color(0xFFFAFbFC);
const appGreenL1 = Colors.greenAccent;
const appGreenL2 = Colors.lightGreen;
const landingColorfotnt = Colors.blueGrey;
const text = Colors.black;

ThemeData applight = ThemeData(
    brightness: Brightness.light,
    primaryColor: appGreenL,
    scaffoldBackgroundColor: appWhite,
    appBarTheme: AppBarTheme(backgroundColor: appGreenL));
ThemeData appDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: appGreenD,
    scaffoldBackgroundColor: appGreenD,
    appBarTheme: AppBarTheme(backgroundColor: appGreenD),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: appWhite),
        bodyText2: TextStyle(color: appWhite)));
