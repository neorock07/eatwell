import "dart:developer";
import "dart:ui";

import "package:eatwell/Activity/DetailResep.dart";
import "package:eatwell/Partial/customDialog.dart";
import "package:flutter/material.dart";
import "package:lucide_icons/lucide_icons.dart";

Widget cardLayerResep(BuildContext context,
    {String? image,
    String? title,
    String? time,
    String? kalori,
    int? id,
    int? user_key,
    String? kategori}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: Colors.grey,
      hoverColor: Colors.grey,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailResep(id)));
        log("data yang dikirim iki coeg : $id");
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage("$image"),
                        fit: BoxFit.cover,
                      )),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black])),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Center(
                  child: FittedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                              child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 8, right: 8, bottom: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Colors.red),
                                    Text(
                                      "$kalori KKal",
                                      style: const TextStyle(
                                          fontFamily: "philo",
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      size: 20,
                                      LucideIcons.timer,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "$time Menit",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.green),
                                    )
                                  ],
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
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey,
                      hoverColor: Colors.grey,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return customDialog(context,
                                  resep_key: id,
                                  user_key: user_key,
                                  kalori: double.parse(kalori.toString()),
                                  kategori: kategori

                                  //                            "user_id":4,
                                  // "resep_id":8,
                                  // "kalori":260,
                                  // "date":"Monday",
                                  // "catatan":"ayam kampung",
                                  // "kategori":"Sarapan"
                                  );
                            });
                      },
                      child: const Icon(
                        LucideIcons.plusCircle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 7, left: 16, right: 16),
              child: Center(
                child: Text(
                  "$title",
                  style: const TextStyle(
                      fontFamily: "philo",
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget cardDetail(BuildContext context,
    {String? title, IconData? icon, Color? color}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.12,
    width: MediaQuery.of(context).size.height * 0.1,
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            "$title",
            style: const TextStyle(
                fontFamily: "philo",
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )
        ],
      ),
    ),
  );
}
