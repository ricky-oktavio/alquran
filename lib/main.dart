import 'package:alquran/app/units/app_units.dart';
import 'package:flutter/material.dart';
import 'package:alquran/app/units/app_units.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: applight,
      //darkTheme: appDark,
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}
