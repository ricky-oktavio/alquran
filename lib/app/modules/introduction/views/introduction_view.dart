import 'package:alquran/app/routes/app_pages.dart';
import 'package:alquran/app/units/app_units.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Al-Qur'an App",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              "Allah SWT berfirman : “Hai orang-orang yang berselimut (Muhammad), bangunlah (untuk sembahyang) di malam hari, kecuali sedikit (daripadanya), (yaitu) seperduanya atau kurangilah dari seperdua itu sedikit, atau lebih dari seperdua itu. Dan bacalah Al-Quran itu dengan perlahan-lahan.” (QS. Al-Muzzammil : 1-4) ",
              style: TextStyle(fontSize: 16
                  //fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 300,
              height: 300,
              child: Lottie.asset("assets/lottie/animasi_landing.json")),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            child: Text(
              "Mulai membaca Al-Qur'an",
              style: TextStyle(color: Get.isDarkMode ? appWhite : Colors.black),
            ),
            style: ElevatedButton.styleFrom(
                primary: Get.isDarkMode ? appGreenD : appWhite,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
          )
        ],
      ),
    ));
  }
}
