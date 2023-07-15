import "dart:convert";
import "dart:developer";
import "package:http/http.dart" as http;
import "package:intl/intl.dart";

class Riwayat {
  int? id;
  double? kalori;
  DateTime? date;
  String? resep_id;
  String? id_food;

  Riwayat({this.id, this.kalori, this.date});

  factory Riwayat.connectApi(Map<String, dynamic> map) {
    return Riwayat(
        id: map["id"],
        kalori: map["kalori"],
        date: DateTime.tryParse(map["date"]));
  }

  static Future<Riwayat> postData(
      {String? resep_key,
      String? user_key,
      String? food_key,
      double? kalori}) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/riwayat").replace(queryParameters: {
      "resep_key": (resep_key != null) ? resep_key : "21",
      "user_key": user_key,
      "food_key": (food_key != null) ? food_key : "11"
    });
    DateTime waktuNow = DateTime.now();
    String waktu = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.SSS').format(waktuNow);
    Map<String, dynamic> body = {
      "user_id": user_key,
      "resep_id": (resep_key != null) ? resep_key : "21",
      "id_food": (food_key != null) ? food_key : "11",
      "kalori": kalori.toString(),
      "date": waktu
    };

    var response = await http.post(url,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    Map<String, dynamic>? jsonData;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as Map<String, dynamic>;
      log("data riwayat : ${jsonData['kalori']}");
    } else {
      log("data: $jsonData");
      log("failed to get data");
    }
    return Riwayat.connectApi(jsonData!);
  }

  static Future<List<dynamic>> getData({String? id}) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/riwayat/user")
        .replace(queryParameters: {"id": id});
    var response = await http.get(url);
    late var jsonData;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as List<dynamic>;
      log('data riwayat berhasil diraih : ${jsonData}');
    } else {
      jsonData = null;
      log("data riwayat gagal diraih");
    }
    return jsonData;
  }

  static Future<List<dynamic>> getDataFilterDate(
      {String? id, String? date}) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/riwayat/user")
        .replace(queryParameters: {"id": id});
    var response = await http.get(url);
    late var jsonData;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as List<dynamic>;
      jsonData.forEach((e) {
        log('${e}');
      });
    } else {
      jsonData = null;
      log("data riwayat gagal diraih");
    }
    return jsonData;
  }
}




// {
//     "user_id":4,
//     "resep_id":null,
//     "id_food":5,
//     "kalori":239,
//     "date":"2023-06-19"
// }



  //  private long id;
  //   private long user_id;
  //   private long resep_id;
  //   private long id_food;
  //   private double kalori;
  //   private Date date;