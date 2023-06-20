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

  static Future<List<dynamic>> getData() async {
    var url = Uri.http("192.168.1.8:8080", "/api/resep");
    var response = await http.get(url);
    late var jsonData;
    late var resepList;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as List<dynamic>;
      resepList = jsonData.map((data) => Resep.connectApi(data)).toList();
    } else {
      log("failed to get data");
    }
    return resepList;
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
