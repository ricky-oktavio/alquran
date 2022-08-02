import 'dart:ui';

import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:alquran/app/units/app_units.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0 : 4,
        title: Text('Al-Quran'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: Icon(Icons.search))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualaikum',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Selamat Datang di Al-Quran app',
                style: TextStyle(fontSize: 27),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    gradient: LinearGradient(colors: [appGreenD, appGreenL2])),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(21),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LAST_READ);
                    },
                    borderRadius: BorderRadius.circular(21),
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: -30,
                              right: 0,
                              child: Opacity(
                                opacity: 0.5,
                                child: Container(
                                    width: 150,
                                    height: 150,
                                    child: Image.asset(
                                      'assets/image/quran1.png',
                                      fit: BoxFit.contain,
                                    )),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book_outlined,
                                      color: appWhite,
                                      size: 20,
                                    ),
                                    SizedBox(width: 7),
                                    Text(
                                      'Terakhir dibaca',
                                      style: TextStyle(
                                          color: appWhite, fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Text(
                                  'Surah ...',
                                  style:
                                      TextStyle(color: appWhite, fontSize: 20),
                                ),
                                Text(
                                  'Juz Ke .. | Ayat Ke ..',
                                  style:
                                      TextStyle(color: appWhite, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                  indicatorColor: appGreenL2,
                  labelColor: text,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: 'Surah',
                    ),
                    Tab(
                      text: 'Juz',
                    ),
                    Tab(
                      text: 'Bookmark',
                    ),
                  ]),
              Expanded(
                  child: TabBarView(
                children: [
                  FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('Tidak Ada Data'),
                          );
                        }
                        print(snapshot.data);
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_SURAH,
                                      arguments: surah);
                                },
                                leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/icon1.png'))),
                                    child:
                                        Center(child: Text("${surah.number}"))),
                                title: Text(
                                    "${surah.name?.transliteration?.id ?? 'Data kosong'}"),
                                subtitle: Text(
                                    '${surah.numberOfVerses} Ayat | Diturunkan di ${surah.revelation?.id ?? 'Error'}'),
                                trailing:
                                    Text('${surah.name?.short ?? 'error'}'),
                              );
                            });
                      }),
                  FutureBuilder<List<juz.Juz>>(
                      future: controller.getAllJuzz(),
                      builder: (contex, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('Tidak Ada Data'),
                          );
                        }
                        print(snapshot.data);
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (contex, index) {
                              juz.Juz data = snapshot.data![index];
                              String nameStart =
                                  data.start?.split(" - ").first ?? "";
                              String nameEnd =
                                  data.end?.split(" - ").first ?? "";
                              List<Surah> allInJuz = [];
                              List<Surah> rawAllInJuz = [];
                              for (var item in controller.allSurah) {
                                rawAllInJuz.add(item);
                                if (item.name!.transliteration!.id == nameEnd) {
                                  break;
                                }
                              }
                              for (var item in rawAllInJuz.reversed.toList()) {
                                allInJuz.add(item);
                                if (item.name!.transliteration!.id ==
                                    nameStart) {
                                  break;
                                }
                              }

                              return ListTile(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                    "juz": data,
                                    "surah": allInJuz.reversed.toList()
                                  });
                                },
                                leading: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/icon1.png'))),
                                    child: Center(child: Text("${index + 1}"))),
                                isThreeLine: true,
                                title: Text('Juz ${index + 1}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(' Mulai dari ${data.start}'),
                                    Text(' Sampai dengan ${data.end}')
                                  ],
                                ),
                              );
                            });
                      }),
                  Center(child: Text('data')),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
