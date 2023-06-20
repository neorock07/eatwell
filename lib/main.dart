import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eatwell/Activity/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Route/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your applica
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSplashScreen(
        splashIconSize: MediaQuery.of(context).size.height,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 4),
        backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
        nextScreen: const Homepage(),
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/images/splashlogo.png',
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text(
                  "Eat",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "swash",
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
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
            Column(children: [
              const Text(
                "Healthy Calories,",
                style: TextStyle(
                    fontFamily: "swash", fontSize: 24, color: Colors.black),
              ),
              const Text(
                "Balanced Life",
                style: TextStyle(
                    fontFamily: "swash",
                    fontSize: 30,
                    color: Color.fromRGBO(121, 187, 68, 0.8)),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
