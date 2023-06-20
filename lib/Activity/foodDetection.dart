import 'dart:developer';

import 'package:eatwell/Activity/DisplayPicture.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FoodDetection extends StatefulWidget {
  const FoodDetection({super.key});

  @override
  _FoodDetectionState createState() => _FoodDetectionState();
}

class _FoodDetectionState extends State<FoodDetection> {
  CameraController? _controller;

  Future<void> initCamera() async {
    var cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller?.initialize();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<File> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String dirPath = "${root.path}/foodImg";
    await Directory(dirPath).create(recursive: true);
    String filePath = "${dirPath}/${DateTime.now()}.jpg";

    try {
      XFile? picture = await _controller?.takePicture();
      picture?.saveTo(filePath);
    } catch (e) {
      log("Error : ${e.toString()}");
    }
    return File(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: initCamera(),
          builder: (_, snapshot) =>
              (snapshot.connectionState == ConnectionState.done)
                  ? Container()
                  : const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SpinKitHourGlass(color: Colors.green),
                      ),
                    )),
    );
  }
}
