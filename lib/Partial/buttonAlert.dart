import 'package:eatwell/Api/Jadwal/Jadwal.dart';
import 'package:eatwell/Partial/Util.dart';
import 'package:flutter/material.dart';

Widget buttonAlert(BuildContext context,
    {String? hari,
    String? day,
    int? resep_key,
    int? user_key,
    double? kalori,
    String? kategori}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    width: MediaQuery.of(context).size.width * 0.8,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey,
        onTap: () {
          Jadwal.postJadwal(
                  resep_key: resep_key,
                  user_key: user_key,
                  kalori: kalori,
                  date: day,
                  kategori: kategori)
              .then((value) {
            if (value == true) {
              Util.setToast("Data berhasil disimpan di jadwal $hari");
            } else {
              Util.setToast("Gagal menyimpan data");
            }
          });
        },
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.green,
          child: Center(
            child: Text(
              "$hari",
              style: const TextStyle(
                  fontFamily: "Helvetica", fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );
}
