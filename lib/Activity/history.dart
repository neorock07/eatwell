import 'dart:developer';

import 'package:eatwell/Activity/Coba.dart';
import 'package:eatwell/Api/Edamam/Edamam.dart';
import 'package:eatwell/Api/FoodDetection/FoodClass.dart';
import 'package:eatwell/Api/FoodDetection/FoodDetect.dart';
import 'package:eatwell/Api/Jadwal/Jadwal.dart';
import 'package:eatwell/Api/Resep/Resep.dart';
import 'package:eatwell/Api/Riwayat/Riwayat.dart';
import 'package:eatwell/Api/User/UserController.dart';
import 'package:eatwell/Partial/MainScreenPartial.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Map<String, dynamic>? map;
  List<dynamic>? resep;
  List<dynamic>? dt;
  FoodClass? food;
  UserController? user_respon;
  Riwayat? riwayat;
  Jadwal? jadwal;
  Resep? data_resep;
  int? idUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              (data_resep != null) ? "${data_resep!.step}" : "tidak ada data",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),

          // Image(
          //   image: NetworkImage("${resep![1]['foto']}"),
          // ),

          ElevatedButton(
              onPressed: () {
                setBtmLayer(context,
                    kalori: "120", name: "Bakwan", confidence: "0.9");
              },
              child: const Text("Klik coba riwayat")),
          ElevatedButton(
              onPressed: () {
                Riwayat.postData(
                    resep_key: "4", user_key: "1", food_key: null, kalori: 190);
              },
              child: const Text("Klik coba tambah riwayat")),
          Align(
            alignment: Alignment.center,
            child: Text(
              (food != null)
                  ? "${food?.id} | ${food?.nama}\n| ${food?.kelas} | ${food?.kalori}"
                  : "tidak ada data",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       FoodClass.getDataClass("2").then((value) {
          //         food = value;
          //         setState(() {});
          //       });
          //     },
          //     child: const Text("Klik fOODCLASS")),
          Align(
            alignment: Alignment.center,
            child: Text(
              (map != null)
                  ? "${map!['class']} | ${map!['confidence']}"
                  : "tidak ada data",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Riwayat.getDataFilterDate(id: "1", date: "");
              },
              child: const Text("Klik Riwayat today")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Coba(120)));
              },
              child: const Text("Klik Coba")),
          Align(
            alignment: Alignment.center,
            child: Text(
              (user_respon != null)
                  ? "${user_respon?.message} | ${user_respon?.status}"
                  : "tidak ada data",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/resep");
              },
              child: const Text("Klik untuk Resep")),

          ElevatedButton(
              onPressed: () {
                Jadwal.getJadwal(4);
              },
              child: const Text("Klik untuk jadwal")),
          Align(
            alignment: Alignment.center,
            child: Text(
              (riwayat != null)
                  ? "${riwayat?.id} | ${riwayat?.date}"
                  : "tidak ada data",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: const Text("Login Screen")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              child: const Text("Register Screen")),
        ],
      ),
    );
  }
}
