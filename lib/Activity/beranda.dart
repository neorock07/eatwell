import 'dart:developer';

import 'package:eatwell/Api/Edamam/Edamam.dart';
import 'package:eatwell/Api/Jadwal/Jadwal.dart';
import 'package:eatwell/Api/Resep/Resep.dart';
import 'package:eatwell/Api/User/UserController.dart';
import 'package:eatwell/Partial/MainScreenPartial.dart';
import 'package:eatwell/Partial/Util.dart';
import 'package:eatwell/Partial/jadwalList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eatwell/Partial/cardDashboard.dart';
import 'package:flutter/foundation.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  String? name;
  TextEditingController _controller = TextEditingController();
  bool? isDel = true;
  Edamam? edamam;
  int? idUser;
  List<dynamic>? jadwal;
  List<dynamic>? resep;
  SharedPreferences? pref;
  double? berat, aktivitas, kaloriNeed;
  int? tinggi, umur;
  UserController? user;
  DateTime? lahirUser;
  var btmContext;
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
  Future<bool> getUsername() async {
    pref = await SharedPreferences.getInstance();

    UserController.fromJson(pref!.getString('username')!).then((value) {
      user = value;
      setState(() {
        log("data iki lo ancukkk : ${user!.lahir}");
        lahirUser = user!.lahir;
        umur = DateTime.now().year - lahirUser!.year;
        if (user!.jenis_kelamin == 'L') {
          switch (user!.aktivitas) {
            case "Jarang":
              kaloriNeed = 88.362 +
                  (13.397 * user!.berat!) +
                  (4.799 * user!.tinggi!) -
                  (5.677 * umur!) * 1.2;
              break;
            case "Sedang":
              kaloriNeed = 88.362 +
                  (13.397 * user!.berat!) +
                  (4.799 * user!.tinggi!) -
                  (5.677 * umur!) * 1.8;
              break;
            case "Tinggi":
              kaloriNeed = 88.362 +
                  (13.397 * user!.berat!) +
                  (4.799 * user!.tinggi!) -
                  (5.677 * umur!) * 2.5;
              break;
          }
        } else {
          switch (user!.aktivitas) {
            case "Jarang":
              kaloriNeed = 447.593 +
                  (9.247 * user!.berat!) +
                  (3.098 * user!.tinggi!) -
                  (4.330 * umur!) * 1.2;
              break;
            case "Sedang":
              kaloriNeed = 447.593 +
                  (9.247 * user!.berat!) +
                  (3.098 * user!.tinggi!) -
                  (4.330 * umur!) * 1.8;
              break;
            case "Tinggi":
              kaloriNeed = 447.593 +
                  (9.247 * user!.berat!) +
                  (3.098 * user!.tinggi!) -
                  (4.330 * umur!) * 2.5;
              break;
          }
        }
      });
    });

    //get data jadwal pada hari ini
    UserController.getIdByName(pref!.getString("username")).then((value) {
      idUser = value;
      setState(() {
        String dayName = DateFormat('EEEE').format(DateTime.now());
        Jadwal.fromDate(idUser, dayName).then((value) {
          jadwal = value;
          setState(() {
            if (jadwal != null) {
              Resep.fromKalori(jadwal![0]['kalori']).then((value) {
                resep = value;
                setState(() {
                  log("data jadwal  terambil $jadwal");
                  // log("data resep  terambil ${resep![0]['step']}");
                });
              });
              int i = 0;
              jadwal!.forEach((e) {
                log("data jadwal  terambil ${jadwal![i]['kalori'].toString()}");
                i++;
              });
            }
          });
        });
      });
    });

    return (name != null);
  }

  @override
  void initState() {
    super.initState();

// laki-laki --> BMR = 88.362 + (13.397 x berat) + (4.799 x tinggi) - (5.677 x umur)
// wanita -->    BMR = 447.593 + (9.247 * user!.berat!) + (3.098 user!.tinggi!) - (4.330 * umur!)

    FutureBuilder(
        future: getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Text("done");
          } else {
            return Text("done");
          }
        });
  }

  String urlApp =
      "https://www.shutterstock.com/image-photo/assortment-various-barbecue-vegan-food-260nw-1738904081.jpg";
  late String greeting;
  late int indexGreet;
  Widget setGreeting({String? namaUser}) {
    List<String> bg = [
      "https://i.pinimg.com/originals/5c/14/e4/5c14e432c78eec264e21fe86edd8624f.png",
      "https://i.pinimg.com/originals/f1/38/d0/f138d096850c82902ee2d5bb4c985b82.png",
      "https://i.pinimg.com/originals/f4/ff/ae/f4ffae060f8bfee6ca5cb4d63f6144d8.png",
      "https://i.pinimg.com/originals/03/92/43/039243310f5fb8e4578602d0bb2af5fc.png"
    ];
    DateTime time = DateTime.now();
    if (time.hour >= 0 && time.hour <= 8) {
      greeting = "Pagi";
      indexGreet = 0;
    } else if (time.hour >= 9 && time.hour <= 14) {
      greeting = "Siang";
      indexGreet = 1;
    } else if (time.hour >= 15 && time.hour <= 18) {
      greeting = "Sore";
      indexGreet = 2;
    } else {
      greeting = "Malam";
      indexGreet = 3;
    }
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("${bg[indexGreet]}"), fit: BoxFit.fill)),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.transparent,
            Color.fromRGBO(225, 238, 208, 1),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 35, left: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(children: [
            const Text(
              "Selamat",
              style: TextStyle(
                  fontFamily: "swash",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              " ${greeting},",
              style: const TextStyle(
                  fontFamily: "swash",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ]),
          Align(
              alignment: Alignment.topLeft,
              child: (pref != null)
                  ? Text(
                      "${pref!.getString('username')}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontFamily: "swash",
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  : const SpinKitDualRing(color: Colors.green))
          // Text("${resep!.nama}")
        ]),
      ),
    ]);
  }

  Widget cardDashBoard(
      {String? url,
      String? msg,
      Color? color,
      String? image,
      double? percent}) {
    return SizedBox(
      height: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? MediaQuery.of(context).size.height * 0.22
          : MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: (color != null) ? color : Colors.white,
        elevation: 1,
        shadowColor: Colors.white.withOpacity(0.7),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: 120,
                width: 120,
                child: (image != null)
                    ? Image.network(
                        image,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        "assets/images/food.png",
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Asupan Kalori Hari Ini",
                    style: TextStyle(
                        fontFamily: "philo",
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 8, bottom: 5),
                  child: CircularPercentIndicator(
                    radius: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? MediaQuery.of(context).size.height * 0.07
                        : MediaQuery.of(context).size.height * 0.13,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 10,
                    percent: (percent != null) ? percent : 0.3,
                    center: Text(
                      (kaloriNeed != null)
                          ? "${kaloriNeed!.toStringAsFixed(1)} KKal"
                          : "0 KKal",
                      style: const TextStyle(
                          fontFamily: "Noto",
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: const Color.fromRGBO(121, 187, 68, 0.8),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget cardMealPlan(
      {String? url,
      String? kategori,
      String? title,
      String? deskripsi,
      String? kalori}) {
    return SizedBox(
      height: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? MediaQuery.of(context).size.height * 0.15
          : MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.green,
            hoverColor: Colors.green,
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? MediaQuery.of(context).size.height * 0.12
                        : MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(url!), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.height * 0.04
                                : MediaQuery.of(context).size.height * 0.1,
                            // width: MediaQuery.of(context).size.width * 0.2,
                            child: Card(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: const Color.fromRGBO(241, 241, 239, 1),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "$kategori",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "roboto",
                                        fontSize: (MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait)
                                            ? 10
                                            : 15,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? MediaQuery.of(context).size.height * 0.04
                                : MediaQuery.of(context).size.height * 0.1,
                            // width: MediaQuery.of(context).size.width * 0.2,
                            child: Card(
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: Color.fromARGB(255, 255, 192, 165),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "$kalori KKal",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.bold,
                                        fontSize: (MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait)
                                            ? 10
                                            : 15,
                                        color:
                                            Color.fromARGB(255, 146, 42, 11)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Text(
                        "$title",
                        style: TextStyle(
                            fontFamily: "philo",
                            fontSize: (MediaQuery.of(context).orientation ==
                                    Orientation.portrait)
                                ? 17
                                : 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: SizedBox(
                        height: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? MediaQuery.of(context).size.height * 0.05
                            : MediaQuery.of(context).size.height * 0.2,
                        width: (MediaQuery.of(context).size.width * 0.9) -
                            (MediaQuery.of(context).size.width * 0.4),
                        child: Text(
                          "$deskripsi",
                          style: TextStyle(
                              fontFamily: "roboto",
                              fontSize: (MediaQuery.of(context).orientation ==
                                      Orientation.portrait)
                                  ? 12
                                  : 18,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categories({String? url, String? nama}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.height * 0.08,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: NetworkImage(url!), fit: BoxFit.cover)),
        ),
      ),
      Text(
        "${nama}",
        style: const TextStyle(
            fontFamily: "swash",
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      )
    ]);
  }

  Widget searchView({String? hint}) {
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
              _controller.text = txt;
              Edamam.getJson(_controller.text.toString()).then((value) {
                edamam = value;
                setState(() {
                  if (edamam != null) {
                    seeBottomSheet(context,
                        label: edamam?.name,
                        kalori: edamam?.kalori!.toStringAsFixed(2),
                        protein: edamam?.protein!.toStringAsFixed(2),
                        carbo: edamam?.carbo!.toStringAsFixed(2),
                        fat: edamam?.fat!.toStringAsFixed(2),
                        user_key: idUser.toString(),
                        btmContex: btmContext);
                  } else {
                    Util.setToast(
                        "data ${_controller.text.toString()} tidak dapat ditemukan");
                  }
                });
              });
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 2, right: 12, top: 15),
                hintText: (hint != null) ? hint : "Cari makanan",
                border: InputBorder.none,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = "";
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

  Widget HomeScreen(BuildContext context, {String? username}) {
    return Stack(children: [
      SingleChildScrollView(
        child: SizedBox(
          height: (MediaQuery.of(context).orientation == Orientation.portrait)
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              (username != null)
                  ? setGreeting(namaUser: username)
                  : const SpinKitDancingSquare(color: Colors.green),
              const SizedBox(
                height: 20,
              ),
              searchView(),
              cardDashBoard(color: const Color.fromRGBO(34, 34, 34, 1)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8, left: 10),
                        child: Text(
                          "My meal plans",
                          style: TextStyle(
                              fontFamily: "swash",
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.grey,
                              onTap: () {
                                setBtmJadwal(context);
                                // Navigator.pop(btmContext);
                              },
                              child: const Text(
                                "View all",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: "roboto",
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              (resep != null)
                  ? cardMealPlan(
                      url: (resep != null) ? "${resep![0]['foto']}" : "",
                      title: (resep != null) ? "${resep![0]['nama']}" : "",
                      kategori:
                          (resep != null) ? "${resep![0]['kategori']}" : "",
                      deskripsi:
                          (resep != null) ? "${resep![0]['deskripsi']}" : "",
                      kalori: (resep != null) ? "${resep![0]['kalori']}" : "",
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Image.asset(
                        "assets/images/none.png",
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Browse by Categories",
                    style: TextStyle(
                        fontFamily: "swash",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    categories(
                        url:
                            "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1",
                        nama: "Sayuran"),
                    categories(
                        url:
                            "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1",
                        nama: "Daging"),
                    categories(
                        url:
                            "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1",
                        nama: "Smoothies"),
                    categories(
                        url:
                            "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1",
                        nama: "Low-Fat")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
      // backgroundColor: Colors.white,
      body: HomeScreen(context,
          username: (pref != null) ? pref!.getString("username") : 'User'),
    );
  }
}


// FutureBuilder<bool>(
//           future: getUsername(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return HomeScreen(context, username: name);
//             } else {
//               return HomeScreen(context, username: "");
//             }
//           })
