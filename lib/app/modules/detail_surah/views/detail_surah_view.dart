import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/data/models/surah_detail.dart' as detail;
import 'package:alquran/app/units/app_units.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Surah ${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error..'}'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [appGreenD, appGreenL2])),
              margin: EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error..'}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '(${surah.name?.translation?.id?.toUpperCase() ?? 'Error..'})',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${surah.numberOfVerses ?? 'Error..'} Ayat | ${surah.revelation?.id}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${surah.tafsir?.id ?? 'Error..'}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
                builder: (context, snapshpot) {
                  if (snapshpot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshpot.hasData) {
                    return Center(
                      child: Text('Tidak ada data'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshpot.data?.verses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshpot.data?.verses == null ||
                          snapshpot.data?.verses?.length == 0) {
                        return Center(
                          child: Text('Tidak ada data'),
                        );
                      }
                      detail.Verse? ayat = snapshpot.data?.verses?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            color: Colors.grey[50],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/image/icon1.png'))),
                                      child:
                                          Center(child: Text("${index + 1}"))),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon:
                                              Icon(Icons.bookmark_add_rounded)),
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
                            '${ayat!.text?.arab}',
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
                            style: TextStyle(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${ayat.translation?.id}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      );
                    },
                  );
                })
          ],
        ));
  }
}
