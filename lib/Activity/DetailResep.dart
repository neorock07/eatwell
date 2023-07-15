import 'dart:developer';

import 'package:bulleted_list/bulleted_list.dart';
import 'package:eatwell/Api/Resep/Resep.dart';
import 'package:eatwell/Partial/cardResep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

class DetailResep extends StatefulWidget {
  final int? id;
  DetailResep(this.id);

  @override
  _DetailResepState createState() {
    return _DetailResepState(this.id);
  }
}

class _DetailResepState extends State<DetailResep> {
  int? id;
  Resep? _dataResep;
  String? _step, _bahan, _nama, _lama, _foto, _level;
  String? _kalori;
  List<String>? _newStep, _newBahan;
  bool? isResize = false;
  bool? isResize2 = false;

  _DetailResepState(this.id);

  @override
  void initState() {
    super.initState();
    Resep.getDataById(id).then((value) {
      _dataResep = value;
      setState(() {
        _step = _dataResep!.step;
        _bahan = _dataResep!.bahan;
        _newStep = _step!.split(";");
        _newBahan = _bahan!.split(";");
        _nama = _dataResep!.nama;
        _kalori = _dataResep!.kalori!.round().toString();
        _lama = _dataResep!.lama;
        _foto = _dataResep!.foto;
        _level = _dataResep!.level;

        log("${_newStep}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
        body: (_dataResep != null)
            ? Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Image.network(
                      "${_foto}",
                      height: MediaQuery.of(context).size.height * 0.6,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  DraggableScrollableSheet(
                      initialChildSize: 0.6,
                      minChildSize: 0.6,
                      maxChildSize: 0.9,
                      builder: ((context, scrollController) {
                        return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: ListView(
                                    controller: scrollController,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Text(
                                                    "${_nama}",
                                                    style: const TextStyle(
                                                        fontFamily: "swash",
                                                        color: Colors.green,
                                                        fontSize: 25),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Material(
                                                  child: InkWell(
                                                    splashColor: Colors.grey,
                                                    hoverColor: Colors.grey,
                                                    onTap: () {
                                                      Share.share(
                                                          "Halo, saya menggunakan aplikasi EatWell ini sangat bermanfaat untuk memantau asupan kalori saya, Yuk download sekarang!\n\nBerikut Resep ${_nama} : Bahan\n${_newBahan}\nCara membuat :\n${_newStep}",
                                                          subject:
                                                              "pesan singkat");
                                                    },
                                                    child: const Icon(
                                                        LucideIcons.share2),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10, top: 8),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty.all(
                                                                  const Size(
                                                                      5, 5)),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .white),
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          25)))),
                                                      onPressed: () {
                                                        isResize = !isResize!;
                                                        setState(() {});
                                                      },
                                                      child: const Text(
                                                        "A",
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            color:
                                                                Colors.black),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              cardDetail(context,
                                                  title: "${_kalori} KKal",
                                                  icon: Icons
                                                      .local_fire_department_rounded,
                                                  color: Color.fromARGB(
                                                          255, 226, 109, 31)
                                                      .withOpacity(0.8)),
                                              cardDetail(context,
                                                  title: _level,
                                                  icon: Icons.bar_chart_rounded,
                                                  color: Color.fromARGB(
                                                          255, 83, 206, 42)
                                                      .withOpacity(0.8)),
                                              cardDetail(context,
                                                  title: "${_lama} Menit",
                                                  icon: Icons.av_timer_rounded,
                                                  color: Color.fromARGB(
                                                          255, 54, 158, 210)
                                                      .withOpacity(0.8)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text("Bahan-bahan",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Helvetica",
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          BulletedList(
                                            listItems: _newBahan!,
                                            style: TextStyle(
                                                fontSize:
                                                    (isResize!) ? 22 : 15),
                                            listOrder: ListOrder.ordered,
                                            bulletType: BulletType.numbered,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text("Langkah-langkah",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Helvetica",
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          BulletedList(
                                            listItems: _newStep!,
                                            style: TextStyle(
                                                fontSize:
                                                    (isResize!) ? 22 : 15),
                                            listOrder: ListOrder.ordered,
                                            bulletType: BulletType.numbered,
                                          ),
                                        ],
                                      ),
                                    ])));
                      }))
                ],
              )
            : const SpinKitDualRing(color: Colors.green));
  }
}
