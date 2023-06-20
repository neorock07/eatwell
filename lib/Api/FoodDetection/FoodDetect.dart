import "dart:developer";

import "package:http/http.dart" as http;
import "dart:convert";

class FoodDetect {
  final String? kelas;
  double? confidence;
  FoodDetect({this.kelas, this.confidence});

  factory FoodDetect.fromJson(Map<String, dynamic> map) {
    return FoodDetect(kelas: map["class"], confidence: map["confidence"]);
  }

  static Future<Map<String, dynamic>?> predict(String? url) async {
    var endpoint = 'https://detect.roboflow.com/foodrecognition-wm130/1';
    var apiKey = 'N66y8jhna3e6IyubaIXl';
    Map<String, dynamic>? map;
    var uri = Uri.parse(endpoint).replace(queryParameters: {
      'api_key': apiKey,
      'image': url,
    });
    var response =
        await http.post(uri, headers: {'Content-Type': 'application/json'});
    late FoodDetect? dataResult;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var jsonData = (data as Map<String, dynamic>)["predictions"];
      map = Map<String, dynamic>.from(jsonData[0]);
      log("data : ${map['confidence']}");
    } else {
      dataResult = null;
      log("failed to get image : ${response.statusCode}");
    }
    return map;
  }
}


// {
//     "predictions": [
//         {
//             "x": 189.5,
//             "y": 100,
//             "width": 163,
//             "height": 186,
//             "class": "helmet",
//             "confidence": 0.544
//         }
//     ],
//     "image":
//         {
//          "width": 2048,
//         "height": 1371
//         }
// }