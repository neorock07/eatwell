import "dart:convert";
import "package:http/http.dart" as http;

class Jadwal {
  int? id;
  int? user_id;
  int? resep_id;
  double? kalori;
  DateTime? date;
  String? catatan;
  String? kategori;

  Jadwal(
      {this.id,
      this.user_id,
      this.resep_id,
      this.kalori,
      this.date,
      this.catatan,
      this.kategori});

  factory Jadwal.connectApi(Map<String, dynamic> map) {
    return Jadwal(
        id: map["id"],
        kalori: map["kalori"],
        date: DateTime.tryParse(map["date"]),
        catatan: map["catatan"],
        kategori: map["kategori"]);
  }
}

// - id
// - user_id
// - resep_id
// - kalori
// - date
// - catatan
// - kategori
