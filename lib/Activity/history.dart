import 'package:eatwell/Api/FoodDetection/FoodDetect.dart';
import 'package:eatwell/Api/Resep/Resep.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Resep? resep;
  Map<String, dynamic>? map;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              (resep != null)
                  ? "${resep?.id} | ${resep?.nama}\n| ${resep?.deskripsi} | ${resep?.kalori} | ${resep?.riwayat}"
                  : "tidak ada data",
              style: const TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Resep.getData().then((value) {
                  resep = value[0];
                  setState(() {});
                });
              },
              child: const Text("Klik")),
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
                FoodDetect.predict(
                        "https://www.resepkuerenyah.com/wp-content/uploads/2015/09/Cara-Membuat-Batagor-Bandung-Spesial-Enak.png")
                    .then((value) {
                  map = value;
                  setState(() {});
                });
              },
              child: const Text("Klik")),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: const Text("Login Screen")),
        ],
      ),
    );
  }
}
