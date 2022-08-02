import 'package:alquran/app/data/models/juz.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/data/models/surah_detail.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<Surah> allSurah = [];
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.sutanlab.id/surah");
    var res = await http.get(url);
    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  Future<List<Juz>> getAllJuzz() async {
    List<Juz> alljuzz = [];
    for (int i = 1; i <= 30; i++) {
      Uri url = Uri.parse("https://api.quran.sutanlab.id/juz/$i");
      var res = await http.get(url);
      Map<String, dynamic> data =
          (json.decode(res.body) as Map<String, dynamic>)["data"];
      Juz juz = Juz.fromJson(data);
      alljuzz.add(juz);
    }
    return alljuzz;
  }
}
