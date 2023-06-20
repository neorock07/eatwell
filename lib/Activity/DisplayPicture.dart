import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPicture extends StatelessWidget {
  final String imgPath;
  const DisplayPicture({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: Image.file(File(imgPath)),
    );
  }
}
