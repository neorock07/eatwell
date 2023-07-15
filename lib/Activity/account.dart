import 'dart:developer';

import 'package:eatwell/Api/User/UserController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? nama, tinggi, berat, jenis_kelamin, umur;
  UserController? user;
  DateTime? lahirUser;
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");

  Future getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    nama = pref.getString("username");
    UserController.fromJson(nama!).then((value) {
      user = value;
      setState(() {
        tinggi = user!.tinggi.toString();
        berat = user!.berat.toString();
        jenis_kelamin = user!.jenis_kelamin;
        lahirUser = user!.lahir;
        umur = (DateTime.now().year - lahirUser!.year).toString();
      });
    });
  }

  Future logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("username");
    log("Dataa  apakah masih : ${pref.getString('username')}");
  }

  @override
  void initState() {
    super.initState();
    FutureBuilder(
        future: getNama(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Text("");
          } else {
            return const Text("");
          }
        });
  }

  Widget cardAccount(
      {String? name,
      String? tinggi,
      String? berat,
      String? umur,
      String? jenis_kelamin}) {
    return Wrap(alignment: WrapAlignment.start, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: const Color.fromARGB(255, 173, 209, 126),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(LucideIcons.ruler),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Tinggi",
                              style: TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            (user != null) ? "${tinggi} cm" : "",
                            style: const TextStyle(
                                fontFamily: "Helvetica",
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ]),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(LucideIcons.scale),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Berat",
                              style: TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            (user != null) ? "${berat} kg" : "",
                            style: const TextStyle(
                                fontFamily: "Helvetica",
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ]),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(LucideIcons.scale),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Jenis Kelamin",
                              style: TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            (user != null) ? "${jenis_kelamin}" : "",
                            style: const TextStyle(
                                fontFamily: "Helvetica",
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ]),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(LucideIcons.scale),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Umur",
                              style: TextStyle(
                                  fontFamily: "Helvetica",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            (user != null) ? "${umur} Tahun" : "",
                            style: const TextStyle(
                                fontFamily: "Helvetica",
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text(
          "Setting Akun",
          style:
              TextStyle(fontFamily: "philo", fontSize: 19, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          Column(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://i.pinimg.com/originals/03/92/43/039243310f5fb8e4578602d0bb2af5fc.png"),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                (user != null) ? "${nama}" : "",
                style: const TextStyle(
                    fontFamily: "Helvetica",
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          cardAccount(
              name: nama,
              umur: umur,
              jenis_kelamin: jenis_kelamin,
              tinggi: tinggi,
              berat: berat),
          Align(
            alignment: Alignment.center,
            child:
                ElevatedButton(onPressed: logout, child: const Text("Log out")),
          )
        ],
      ),
    );
  }
}
