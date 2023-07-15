import "dart:convert";
import "dart:developer";

import "package:http/http.dart" as http;

class Edamam {
  String? name;
  double? kalori;
  double? protein;
  double? fat;
  double? carbo;
  String? image;
  List<dynamic>? child;
  Edamam(
      {this.name, this.kalori, this.protein, this.fat, this.carbo, this.image});

  Edamam.gotData({
    this.name,
    this.child,
    this.image,
  });

  factory Edamam.fromJson(Map<String, dynamic> map) {
    return Edamam(
        name: map["label"],
        kalori: map['nutrients']["ENERC_KCAL"],
        protein: map['nutrients']["PROCNT"],
        fat: map['nutrients']["FAT"],
        carbo: map['nutrients']["CHOCDF"]);
  }

  static Future<Edamam> getJson(String? input) async {
    var url = Uri.parse("https://api.edamam.com/api/food-database/v2/parser")
        .replace(queryParameters: {
      "ingr": input,
      "app_id": "449b624d",
      "app_key": "3e76e9ce6051b3eb408c7a8debbb7500"
    });
    late var jsonData, listData, listData2;
    Map<String, dynamic>? dataMap;
    var response = await http.get(url);
    // data2 = Edamam.gotData(
    //     name: dataMap["label"],
    //     child: dataMap["nutrients"],
    //     image: dataMap["image"]);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      listData = jsonData["parsed"] as List<dynamic>;
      listData2 = jsonData["hints"] as List<dynamic>;
      if (listData.isNotEmpty) {
        dataMap = Map<String, dynamic>.from(listData[0]["food"]);
      } else if (listData2.isNotEmpty) {
        dataMap = Map<String, dynamic>.from(listData2[0]["food"]);
      } else {
        dataMap = null;
      }
    } else {
      log("failed to get data");
    }
    return Edamam.fromJson(dataMap!);
  }
}
