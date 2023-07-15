import "dart:convert";
import "dart:developer";

import "package:eatwell/Api/Jadwal/Jadwal.dart";
import "package:eatwell/Api/Riwayat/Riwayat.dart";
import "package:http/http.dart" as http;

class Resep {
  int? id;
  String? nama;
  String? bahan;
  String? step;
  double? kalori;
  String? level;
  String? lama;
  String? foto;
  String? deskripsi;
  String? kategori;
  List<Jadwal>? jadwal;
  List<Riwayat>? riwayat;

  Resep(
      {this.id,
      this.nama,
      this.bahan,
      this.step,
      this.kalori,
      this.level,
      this.lama,
      this.foto,
      this.deskripsi,
      this.kategori,
      this.jadwal,
      this.riwayat});

  factory Resep.connectApi(Map<String, dynamic> map) {
    var riwayatList = map["riwayat"] as List<dynamic>;
    var jadwalList = map["jadwal"] as List<dynamic>;

    return Resep(
        id: map["id"],
        nama: map["nama"],
        bahan: map["bahan"],
        step: map["step"],
        kalori: map["kalori"],
        level: map["level"],
        lama: map["lama"],
        foto: map["foto"],
        deskripsi: map["deskripsi"],
        kategori: map["kategori"],
        jadwal: jadwalList.map((data) => Jadwal.connectApi(data)).toList(),
        riwayat: riwayatList.map((data) => Riwayat.connectApi(data)).toList());
  }

  static Future<List<dynamic>?> getData() async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/resep");
    var response = await http.get(url);
    late var jsonData;
    //Map<String, dynamic>? dataMap;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as List<dynamic>;
      log("panjang : ${jsonData.length}");
      //dataMap = Map<String, dynamic>.from(jsonData);
      jsonData.forEach((element) {
        log("data : ${element['nama']} | ${element['kalori']} | ${element['lama']} | ${element['foto']} ");
      });
    } else {
      log("failed to get data");
    }
    return jsonData;
  }

  static Future<Resep?> getDataById(int? id) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/resep/$id");
    var response = await http.get(url);

    late var jsonData;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as Map<String, dynamic>;
      log("contoh data :${jsonData['nama']}");
    } else {
      log("failed to get data");
    }
    return Resep.connectApi(jsonData);
  }

  static Future<List<dynamic>> fromKalori(double? kalori) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/resep/kalori")
        .replace(queryParameters: {"kalori": kalori.toString()});
    var response = await http.get(url);
    late var data;
    if (response.statusCode == 200) {
      data = json.decode(response.body) as List<dynamic>;
    } else {
      data = null;
    }
    return data;
  }
}

// - id
// - nama
// - bahan
// - step
// - kalori
// - level
// - lama
// - foto
// - deskripsi
// - kategori
// - riwayat
// - jadwal
