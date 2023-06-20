import "dart:convert";
import "package:http/http.dart" as http;

class Riwayat {
  int? id;
  double? kalori;
  DateTime? date;

  Riwayat({this.id, this.kalori, this.date});

  factory Riwayat.connectApi(Map<String, dynamic> map) {
    return Riwayat(
        id: map["id"],
        kalori: map["kalori"],
        date: DateTime.tryParse(map["date"]));
  }
}
