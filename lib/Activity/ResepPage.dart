import 'dart:developer';

import 'package:eatwell/Api/Resep/Resep.dart';
import 'package:eatwell/Api/User/UserController.dart';
import 'package:eatwell/Partial/SliverHeader.dart';
import 'package:eatwell/Partial/cardResep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResepPage extends StatefulWidget {
  const ResepPage({Key? key}) : super(key: key);

  @override
  _ResepPageState createState() => _ResepPageState();
}

class _ResepPageState extends State<ResepPage> {
  SliverHeader? slv;
  TextEditingController? _controller = TextEditingController();
  List<dynamic> _dataList = [];
  int? idUser;
  SharedPreferences? pref;
  Future getPref() async {
    pref = await SharedPreferences.getInstance();
    UserController.getIdByName(pref!.getString("username")).then((value) {
      idUser = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    Resep.getData().then((value) {
      _dataList = value!;
      setState(() {
        _dataList.removeAt(0);
      });
    });
    FutureBuilder(
        future: getPref(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text("done");
          } else {
            return Text("done");
          }
        });
  }

  Widget searchView(BuildContext context, {String? hint}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color.fromARGB(255, 240, 240, 240),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: TextField(
            controller: _controller,
            onSubmitted: (String txt) async {
              _controller!.text = txt;
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 2, right: 12, top: 15),
                hintText: (hint != null) ? hint : "Cari makanan",
                border: InputBorder.none,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller!.text = "";
                      });
                    },
                    icon: const Icon(
                      LucideIcons.delete,
                      color: Colors.lightGreen,
                    )),
                icon: Icon(
                  LucideIcons.search,
                  color: Colors.grey[500],
                ),
                hintStyle: const TextStyle(
                    fontFamily: "serif", fontWeight: FontWeight.normal)),
          ),
        ),
      ),
    );
  }

  bool? txtVis = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Colors.lightGreen,
              snap: false,
              centerTitle: false,
              title: const Text(
                "Hello..\nMau masak apa hari ini ?",
                style: TextStyle(fontFamily: "swash"),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        txtVis = !txtVis!;
                      });
                    },
                    icon: const Icon(LucideIcons.search))
              ],
              bottom: AppBar(
                backgroundColor: Colors.lightGreen,
                automaticallyImplyLeading: false,
                toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                title: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Colors.transparent,
                  child: Center(
                      child: (txtVis == true)
                          ? AnimatedContainer(
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeIn,
                              child: searchView(context, hint: "Cari Resep"))
                          : Container()),
                ),
              ),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = _dataList[index];
                  return cardLayerResep(context,
                      image: item["foto"],
                      title: item["nama"],
                      time: item["lama"],
                      id: item["id"],
                      kalori: item["kalori"].round().toString(),
                      user_key: idUser,
                      kategori: item["kategori"]);
                }, childCount: _dataList.length),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 7,
                    childAspectRatio: 1))
          ],
        ));
  }
}
