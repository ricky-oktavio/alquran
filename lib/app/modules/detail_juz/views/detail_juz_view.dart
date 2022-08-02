import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detaiJuz = Get.arguments["juz"];
  final List<Surah> detailSurah = Get.arguments["surah"];
  @override
  Widget build(BuildContext context) {
    detailSurah.forEach((element) {
      print(element.name!.transliteration!.id);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Juz ${detaiJuz.juz}'),
          centerTitle: true,
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: detaiJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              if (detaiJuz.verses?.length == 0 ||
                  detaiJuz.verses?.length == null) {
                return Text('Tidak Ada Data');
              }
              juz.Verses ayat = detaiJuz.verses![index];
              if (index != 0) {
                if (ayat.number?.inSurah == 1) {
                  controller.index++;
                }
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    color: Colors.grey[50],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/image/icon1.png'))),
                                  child: Center(
                                      child: Text("${ayat.number?.inSurah}"))),
                              Text(
                                "${detailSurah[controller.index].name?.transliteration?.id ?? ''}",
                                style: TextStyle(
                                    fontSize: 20, fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.bookmark_add_rounded)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.play_arrow)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${ayat.text?.arab}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${ayat.text?.transliteration?.en}',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${ayat.translation?.id}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              );
            }));
  }
}
