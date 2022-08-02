import 'dart:convert';

import 'package:alquran/app/data/models/surah_detail.dart';
import 'package:http/http.dart' as http;

void main() async {
  int juz = 1;
  List<Verse> rawAyah = [];
  List<Map<String, dynamic>> allJuz = [];
  for (var i = 0; i < 114; i++) {
    var res =
        await http.get(Uri.parse("https://api.quran.sutanlab.id/surah/$i"));
    Map<String, dynamic> rawData = json.decode(res.body)["data"];
    DetailSurah data = DetailSurah.fromJson(rawData);
    if (data.verses != null) {
      data.verses!.forEach((element) {
        if (element.meta?.juz == juz) {
          rawAyah.add(element);
        } else {
          print("================");
          print("Succes add $juz");
          allJuz.add({
            "juz": juz,
            "name": data.name?.transliteration?.id ?? '',
            "start": rawAyah[0],
            "end": rawAyah[rawAyah.length - 1],
            "verses": rawAyah,
          });
          juz++;
          rawAyah.clear();
          rawAyah.add(element);
        }
      });
    }
  }
}
