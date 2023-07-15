import 'dart:typed_data';
import 'dart:ui';

import 'package:eatwell/Partial/buttonAlert.dart';
import 'package:flutter/material.dart';

Widget customDialog(BuildContext context,
    {int? resep_key, int? user_key, double? kalori, String? kategori
    // "user_id":4,
    // "resep_id":8,
    // "kalori":260,
    // "date":"Monday",
    // "catatan":"ayam kampung",
    // "kategori":"Sarapan"
    }) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.2,
    width: MediaQuery.of(context).size.width * 0.5,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.transparent),
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.7,
          child: FittedBox(
            child: ClipRect(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Stack(children: [
                  Positioned.fill(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  )),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Tambahkan ke Jadwal",
                          style: TextStyle(
                              fontFamily: "philo",
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        Column(
                          children: [
                            buttonAlert(context,
                                hari: "Senin",
                                day: "Monday",
                                resep_key: resep_key,
                                user_key: user_key,
                                kalori: kalori,
                                kategori: kategori),
                            buttonAlert(context,
                                hari: "Selasa",
                                day: "Tuesday",
                                resep_key: resep_key,
                                user_key: user_key,
                                kalori: kalori,
                                kategori: kategori),
                            buttonAlert(context,
                                hari: "Rabu",
                                day: "Wednesday",
                                resep_key: resep_key,
                                user_key: user_key,
                                kalori: kalori,
                                kategori: kategori),
                            buttonAlert(context,
                                hari: "Kamis",
                                day: "Thursday",
                                resep_key: resep_key,
                                user_key: user_key,
                                kalori: kalori,
                                kategori: kategori),
                            buttonAlert(context,
                                hari: "Jumaat",
                                day: "Friday",
                                resep_key: resep_key,
                                user_key: user_key,
                                kalori: kalori,
                                kategori: kategori),
                            buttonAlert(context,
                                hari: "Sabtu",
                                day: "Saturday",
                                resep_key: resep_key,
                                user_key: user_key,
                                kalori: kalori,
                                kategori: kategori),
                            buttonAlert(context,
                                hari: "Mingggu",
                                day: "Sunday",
                                resep_key: resep_key,
                                user_key: user_key,
                                kalori: kalori,
                                kategori: kategori),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
