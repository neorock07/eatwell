import 'package:eatwell/Activity/account.dart';
import 'package:eatwell/Activity/beranda.dart';
import 'package:eatwell/Activity/foodDetection.dart';
import 'package:eatwell/Activity/history.dart';
import 'package:eatwell/Activity/homepage.dart';
import 'package:eatwell/Activity/loginScreen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Homepage());
      case '/riwayat':
        return MaterialPageRoute(builder: (_) => const History());
      case '/akun':
        return MaterialPageRoute(builder: (_) => const Account());
      case '/beranda':
        return MaterialPageRoute(builder: (_) => const Beranda());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/foodCamera':
        return MaterialPageRoute(builder: (_) => const FoodDetection());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Error Page 404"),
        ),
      );
    });
  }
}
