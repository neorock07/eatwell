import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  String urlApp =
      "https://www.shutterstock.com/image-photo/assortment-various-barbecue-vegan-food-260nw-1738904081.jpg";
  late String greeting;
  Widget _setGreeting() {
    DateTime time = DateTime.now();
    if (time.hour >= 0 && time.hour <= 8) {
      greeting = "Pagi";
    } else if (time.hour >= 9 && time.hour <= 14) {
      greeting = "Siang";
    } else if (time.hour >= 15 && time.hour <= 18) {
      greeting = "Sore";
    } else {
      greeting = "Malam";
    }
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(children: [
        const Text(
          "Selamat",
          style: TextStyle(
              fontFamily: "swash",
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        Text(
          " ${greeting},",
          style: TextStyle(
              fontFamily: "swash",
              fontSize: 20,
              color: Color.fromRGBO(121, 187, 68, 0.8),
              fontWeight: FontWeight.bold),
        ),
      ]),
      const Align(
        alignment: Alignment.topLeft,
        child: Text(
          " Eka",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontFamily: "swash",
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }

  Widget _cardDashBoard(
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
                        ? MediaQuery.of(context).size.height * 0.065
                        : MediaQuery.of(context).size.height * 0.13,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 10,
                    percent: (percent != null) ? percent : 0.3,
                    center: const Text(
                      "13 KKal",
                      style: TextStyle(
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

  Widget _cardMealPlan(
      {String? url,
      String? kategori,
      String? title,
      String? deskripsi,
      int? kalori}) {
    return InkWell(
      splashColor: Colors.green,
      hoverColor: Colors.green,
      child: SizedBox(
        height: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.height * 0.15
            : MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
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
                    child: SizedBox(
                      height: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? MediaQuery.of(context).size.height * 0.04
                          : MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Card(
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: const Color.fromRGBO(241, 241, 239, 1),
                        child: Center(
                          child: Text(
                            "LUNCH",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "roboto",
                                fontSize: (MediaQuery.of(context).orientation ==
                                        Orientation.portrait)
                                    ? 10
                                    : 15,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      "Sambel Terong",
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
                        "Sambel Terong adalah terong yang dimasak balado",
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
    );
  }

  Widget _categories({String? url, String? nama}) {
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

  Widget _searchView({String? hint}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color.fromARGB(255, 240, 240, 240),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 2, right: 12),
                hintText: (hint != null) ? hint : "Cari makanan,resep..",
                border: InputBorder.none,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
      body: Stack(children: [
        SingleChildScrollView(
          child: SizedBox(
            height: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height * 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 40, left: 15),
                    child: _setGreeting()),
                const SizedBox(
                  height: 20,
                ),
                _searchView(),
                _cardDashBoard(color: const Color.fromRGBO(34, 34, 34, 1)),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Stack(
                      children: const [
                        Padding(
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
                          padding: EdgeInsets.only(top: 8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              splashColor: Colors.grey,
                              child: Text(
                                "View all",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: "roboto",
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                _cardMealPlan(
                    url:
                        "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1"),
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
                      _categories(
                          url:
                              "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1",
                          nama: "Sayuran"),
                      _categories(
                          url:
                              "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1",
                          nama: "Daging"),
                      _categories(
                          url:
                              "https://i0.wp.com/bosmeal.com/wp-content/uploads/2020/05/Sambal-Terong-Balado.jpg?fit=800%2C708&ssl=1",
                          nama: "Smoothies"),
                      _categories(
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
      ]),
    );
  }
}
