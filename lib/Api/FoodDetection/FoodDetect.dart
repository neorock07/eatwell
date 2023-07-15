import "dart:developer";
import "dart:io";

import "package:eatwell/Api/FoodDetection/FoodClass.dart";
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
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var jsonData = (data as Map<String, dynamic>)["predictions"];
      map = Map<String, dynamic>.from(jsonData[0]);
      log("data : ${map['confidence']}");
    } else {
      log("failed to get image : ${response.statusCode}");
    }
    return map;
  }

  static Future<Map<String, dynamic>?> predictAsset(
      {String? path, String? name}) async {
    File file = File(path!);
    List<int> imgByte = await file.readAsBytes();
    String encode = base64Encode(imgByte);
    Map<String, dynamic>? map;

    var endpoint = 'https://detect.roboflow.com/foodrecognition-wm130/1';
    var apiKey = 'N66y8jhna3e6IyubaIXl';
    var uri = Uri.parse(endpoint).replace(queryParameters: {
      'api_key': apiKey,
      'name': name,
    });
    var response = await http.post(uri,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: encode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data.containsKey("predictions")) {
        var jsonData = data["predictions"] as List<dynamic>;
        if (jsonData.isNotEmpty) {
          map = Map<String, dynamic>.from(jsonData[0]);
          var confidence = map['confidence'];
          var fr = FoodClass.getDataClass(map['class']);
          log("Data nama: $fr");
          log("Confidence: $confidence");
        } else {
          log("Empty predictions data");
        }
      } else {
        log("Invalid response format: Missing 'predictions' key");
      }
    } else {
      log("Failed to post image: ${response.statusCode}");
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