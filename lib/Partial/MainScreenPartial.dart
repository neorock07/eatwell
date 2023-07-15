import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eatwell/Api/Riwayat/Riwayat.dart';
import 'package:eatwell/Partial/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucide_icons/lucide_icons.dart';

Widget MainScreen(Widget page, BuildContext context) {
  return AnimatedSplashScreen(
    splashIconSize: MediaQuery.of(context).size.height,
    splashTransition: SplashTransition.fadeTransition,
    animationDuration: const Duration(seconds: 4),
    backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
    nextScreen: page,
    splash: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          'assets/images/logo2.png',
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
        ),
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Eat",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "swash",
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Well",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "swash",
                  fontSize: 25,
                  color: Color.fromRGBO(121, 187, 68, 0.8),
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        const SizedBox(
          height: 30,
        ),
        SpinKitDoubleBounce(
          color: Colors.green[600],
          size: 20,
          duration: const Duration(seconds: 4),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        const Column(children: [
          Text(
            "Healthy Calories,",
            style: TextStyle(
                fontFamily: "swash", fontSize: 24, color: Colors.black),
          ),
          Text(
            "Balanced Life",
            style: TextStyle(
                fontFamily: "swash",
                fontSize: 30,
                color: Color.fromRGBO(121, 187, 68, 0.8)),
          ),
        ]),
      ],
    ),
  );
}

Future setBtmLayer(BuildContext context,
    {String? name,
    BuildContext? btmContex,
    String? kalori,
    String? confidence,
    String? user_key,
    String? food_key}) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (context) {
        btmContex = context;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Hasil Prediksi",
                  style: TextStyle(
                      fontFamily: "philo",
                      fontSize: 16,
                      color: Color.fromARGB(255, 93, 90, 90)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Prediksi",
                      style: TextStyle(
                          fontFamily: "philo",
                          fontSize: 16,
                          color: Color.fromARGB(255, 93, 90, 90)),
                    ),
                    Text(
                      "$name",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tingkat Kepercayaan",
                      style: TextStyle(
                          fontFamily: "philo",
                          fontSize: 16,
                          color: Color.fromARGB(255, 93, 90, 90)),
                    ),
                    Text(
                      "$confidence %",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                      Center(
                        child: Text(
                          "Kalori",
                          style: TextStyle(
                              fontFamily: "philo",
                              fontSize: 16,
                              color: Color.fromARGB(255, 93, 90, 90)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        LucideIcons.flame,
                        color: Color.fromARGB(255, 173, 61, 5),
                      )
                    ]),
                    Text(
                      "$kalori Kkal/100g",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.green,
                      hoverColor: Colors.grey,
                      onTap: () {
                        Riwayat.postData(
                            resep_key: "21",
                            user_key: user_key,
                            food_key: food_key,
                            kalori: double.parse(kalori!));
                        Util.setToast("Selamat menikmati !!!");
                        Navigator.pop(btmContex!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(50, 116, 0, 1),
                              Color.fromRGBO(150, 185, 31, 1)
                            ])),
                        child: const Center(
                          child: Text(
                            "Saya makan ini sekarang!",
                            style: TextStyle(
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

Future seeBottomSheet(BuildContext context,
    {String? label,
    String? kalori,
    String? carbo,
    String? protein,
    String? fat,
    String? img,
    String? user_key,
    BuildContext? btmContex}) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (context) {
        btmContex = context;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 2,
              ),
              const Text(
                "Informasi Gizi",
                style: TextStyle(
                    fontFamily: "philo", fontSize: 14, color: Colors.grey),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nama",
                      style: TextStyle(
                          fontFamily: "philo",
                          fontSize: 16,
                          color: Color.fromARGB(255, 93, 90, 90)),
                    ),
                    Text(
                      "$label",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                      Center(
                        child: Text(
                          "Kalori",
                          style: TextStyle(
                              fontFamily: "philo",
                              fontSize: 16,
                              color: Color.fromARGB(255, 93, 90, 90)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        LucideIcons.flame,
                        color: Color.fromARGB(255, 173, 61, 5),
                      )
                    ]),
                    Text(
                      "$kalori Kkal/100g",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                      Center(
                        child: Text(
                          "Protein",
                          style: TextStyle(
                              fontFamily: "philo",
                              fontSize: 16,
                              color: Color.fromARGB(255, 93, 90, 90)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        LucideIcons.fish,
                        color: Color.fromARGB(255, 173, 61, 5),
                      )
                    ]),
                    Text(
                      "$protein g",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                      Center(
                        child: Text(
                          "Karbohidrat",
                          style: TextStyle(
                              fontFamily: "philo",
                              fontSize: 16,
                              color: Color.fromARGB(255, 93, 90, 90)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        LucideIcons.wheat,
                        color: Color.fromARGB(255, 173, 61, 5),
                      )
                    ]),
                    Text(
                      "$carbo g",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(children: [
                      Center(
                        child: Text(
                          "Lemak",
                          style: TextStyle(
                              fontFamily: "philo",
                              fontSize: 16,
                              color: Color.fromARGB(255, 93, 90, 90)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        LucideIcons.candy,
                        color: Color.fromARGB(255, 173, 61, 5),
                      )
                    ]),
                    Text(
                      "$fat g",
                      style: const TextStyle(
                          fontFamily: "philo",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.green,
                      hoverColor: Colors.grey,
                      onTap: () {
                        Riwayat.postData(
                            resep_key: "21",
                            user_key: user_key,
                            food_key: "11",
                            kalori: double.parse(kalori!));
                        Util.setToast("Selamat menikmati !!!");
                        Navigator.pop(btmContex!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(50, 116, 0, 1),
                              Color.fromRGBO(150, 185, 31, 1)
                            ])),
                        child: const Center(
                          child: Text(
                            "Saya makan ini sekarang!",
                            style: TextStyle(
                                fontFamily: "Helvetica",
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "data akan ditambahkan ke riwayat asupan hari ini",
                style: TextStyle(
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 10),
              ),
            ],
          ),
        );
      });
}
