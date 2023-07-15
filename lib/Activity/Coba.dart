import 'dart:developer';

import 'package:flutter/material.dart';

class Coba extends StatefulWidget {
  int? data;

  //Coba({Key? key, @required this.data }) : super(key: key);
  Coba(this.data);

  @override
  _CobaState createState() {
    return _CobaState(this.data);
  }
}

class _CobaState extends State<Coba> {
  int? data;
  _CobaState(this.data);

  @override
  Widget build(BuildContext context) {
    // data = ModalRoute.of(context)!.settings.arguments as int;
    setState(() {
      log("data kudune : $data");
    });

    return Container(
      child: Text("data : $data"),
    );
  }
}
