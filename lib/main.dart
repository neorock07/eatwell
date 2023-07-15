//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:developer';
import 'package:eatwell/Activity/homepage.dart';
import 'package:eatwell/Activity/loginScreen.dart';
import 'package:eatwell/Partial/MainScreenPartial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Route/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your app
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
  String? username;
  String? password;

  Future<bool> cekPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    password = pref.getString("password");
    log("data yang tersimpan : $username -- $password");
    return (username != null && password != null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: cekPreferences(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  children: [
                    SpinKitPouringHourGlass(color: Colors.green),
                    Text(
                      "Menunggu...",
                      style: TextStyle(fontFamily: "roboto", fontSize: 14),
                    )
                  ],
                ),
              );
            } else if (snapshot.hasData && snapshot.data!) {
              return MainScreen(const Homepage(), context);
            } else {
              return MainScreen(const LoginScreen(), context);
            }
          },
        ));
  }
}
