import "dart:convert";
import "dart:developer";
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

  static Future getJadwal(int? id) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/jadwal/user")
        .replace(queryParameters: {"id": id.toString()});

    late var response, jsonData;
    List<dynamic>? jsonList;

    response = await http.get(url);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as List<dynamic>;
      jsonData.forEach((element) {
        log("data : ${element}");
      });
    } else {
      log("failed to get data");
    }
  }

  static Future<bool?> postJadwal({
    int? resep_key,
    int? user_key,
    double? kalori,
    String? date,
    String? kategori,
  }) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/jadwal").replace(queryParameters: {
      "resep_key": resep_key.toString(),
      "user_key": user_key.toString()
    });

    Map<String, dynamic> requestBody = {
      "user_id": user_key,
      "resep_key": resep_key,
      "kalori": kalori,
      "date": date,
      "catatan": "a",
      "kategori": kategori,
    };

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    bool? kondisi;
    if (response.statusCode == 200) {
      log("berhasil post data jadwal");
      kondisi = true;
    } else {
      log("gagal post data jadwal ${response.statusCode}");
      kondisi = false;
    }
    return kondisi;
  }

  static Future<List<dynamic>> fromDate(int? id, String? date) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/jadwal/date")
        .replace(queryParameters: {"id": id.toString(), "date": date});

    var response = await http.get(url);
    var data;
    if (response.statusCode == 200) {
      data = json.decode(response.body) as List<dynamic>;
      log("berhasil get data jadwal data : $data[0]");
    } else {
      log("failed to get data jadwal");
    }
    return data;
  }
}

// - id
// - user_id
// - resep_id
// - kalori
// - date
// - catatan
// - kategori
