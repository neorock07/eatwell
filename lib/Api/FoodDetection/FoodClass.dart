import "dart:developer";
import "dart:io";

import "package:http/http.dart" as http;
import "dart:convert";

class FoodClass {
  int? id;
  String? nama;
  int? kelas;
  double? kalori;

  FoodClass({this.id, this.nama, this.kelas, this.kalori});

  factory FoodClass.fromJson(Map<String, dynamic> map) {
    return FoodClass(
        id: map["id"],
        nama: map["nama"],
        kelas: map["kelas"],
        kalori: map["kalori"]);
  }

  static Future<Map<String, dynamic>> getDataClass(String? kelas) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/foods/categories")
        .replace(queryParameters: {"kelas": kelas});
    var response = await http.get(url);
    late var jsonData;
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body) as Map<String, dynamic>;
      //resepList = jsonData.map((data) => Resep.connectApi(data)).toList();
      log("data food : $jsonData['nama']");
    } else {
      log("failed to get data");
      jsonData = null;
    }
    return jsonData;
  }
}


  // "id": 4,
  //   "nama": "apel",
  //   "kelas": 2,
  //   "kalori": 52.1,
  //   "food": []