import 'dart:developer';
import 'dart:io';

// import 'package:eatwell/Activity/DisplayPicture.dart';
import 'package:eatwell/Api/FoodDetection/FoodClass.dart';
import 'package:eatwell/Api/FoodDetection/FoodDetect.dart';
import 'package:eatwell/Api/User/UserController.dart';
import 'package:eatwell/Partial/MainScreenPartial.dart';
import 'package:flutter/material.dart';
//import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:camera/camera.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodDetection extends StatefulWidget {
  const FoodDetection({Key? key}) : super(key: key);

  @override
  _FoodDetectionState createState() => _FoodDetectionState();
}

class _FoodDetectionState extends State<FoodDetection> {
  late CameraController _controller;
  int? idUser;
  var btmContex;

  Future<void> initCamera() async {
    var cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
  }

  Future<void> getIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = pref.getString("username")!;
    UserController.getIdByName(name).then((value) {
      idUser = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    FutureBuilder(
        future: getIdUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Text("done");
          } else {
            return const Text("waiting");
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String dirPath = "${root.path}/foodImg";
    await Directory(dirPath).create(recursive: true);
    String filePath = "${dirPath}/${DateTime.now()}.jpg";
    try {
      XFile? picture = await _controller.takePicture();
      picture.saveTo(filePath);
    } catch (e) {
      log("Error : ${e.toString()}");
    }
    return filePath;
  }

  Widget loadingScreen({bool? isPresent}) {
    return (isPresent == true)
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
            child: const Center(
              child: SpinKitPulsingGrid(color: Colors.white),
            ),
          )
        : Container();
  }

  Map<String, dynamic>? resultmodel;
  Map<String, dynamic>? food;
  //FoodClass? foodclass;
  bool? isTap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: initCamera(),
            builder: (_, snapshot) => (snapshot.connectionState ==
                    ConnectionState.done)
                ? Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                _controller.value.aspectRatio,
                            width: MediaQuery.of(context).size.width,
                            child: CameraPreview(_controller),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.009,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              color: const Color.fromARGB(255, 29, 26, 26),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.blue,
                                    onPressed: () async {
                                      isTap = true;

                                      if (!_controller.value.isTakingPicture) {
                                        String result = await takePicture();
                                        await FoodDetect.predictAsset(
                                                path: result,
                                                name: "${DateTime.now()}.jpg")
                                            .then((value) {
                                          resultmodel = value;
                                          setState(() {});
                                          log("data resultmodel : ${resultmodel?['class']}");
                                        });

                                        if (resultmodel?['class'] != null) {
                                          String kelasData =
                                              await resultmodel?['class'];
                                          await FoodClass.getDataClass(
                                                  kelasData)
                                              .then((value) {
                                            food = value;
                                            setState(() {});
                                            double? acc =
                                                resultmodel?['confidence'] *
                                                    100;
                                            setBtmLayer(context,
                                                kalori: "${food?['kalori']}",
                                                name: "${food?['nama']}",
                                                btmContex: btmContex,
                                                confidence:
                                                    acc!.toStringAsFixed(2),
                                                user_key: idUser.toString(),
                                                food_key:
                                                    food?['id'].toString());

                                            log("nama prediksi : ${food?['nama']}");
                                          }).catchError((error) {
                                            log("error fetching : $error");
                                          });
                                        } else {
                                          log("Tidak dapat memprediksi");
                                        }

                                        log("gambar tersimpan");
                                      }
                                    },
                                    child: const Icon(
                                      LucideIcons.camera,
                                      size: 42,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.height /
                                    _controller.value.aspectRatio) *
                                0.2),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.height * 0.5,
                            child: Image.asset(
                              "assets/images/bound.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      (resultmodel != null || isTap == true)
                          ? loadingScreen(isPresent: false)
                          : loadingScreen(isPresent: true)
                    ],
                  )
                : const Center(child: SpinKitHourGlass(color: Colors.green))));
  }
}
