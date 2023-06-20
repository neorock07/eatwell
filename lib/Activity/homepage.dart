import 'package:eatwell/Activity/account.dart';
import 'package:eatwell/Activity/beranda.dart';
import 'package:eatwell/Activity/foodDetection.dart';
import 'package:eatwell/Activity/history.dart';
import 'package:eatwell/main.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currIndex = 0;
  final List<Widget> _child = [
    const Beranda(),
    const History(),
    const Account(),
    const SplashScreen(),
  ];

  void _setSelectedIndex(int index) => setState(() {
        _currIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _child[_currIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currIndex,
          backgroundColor: Colors.white,
          onTap: _setSelectedIndex,
          unselectedItemColor: Colors.grey[500],
          selectedItemColor: const Color.fromRGBO(121, 187, 68, 0.8),
          type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(LucideIcons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(LucideIcons.chefHat), label: "Resep"),
            BottomNavigationBarItem(
                icon: Icon(LucideIcons.history), label: "Riwayat"),
            BottomNavigationBarItem(
                icon: Icon(LucideIcons.user), label: "Akun"),
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Take Picture",
        backgroundColor: const Color.fromRGBO(121, 187, 68, 1),
        onPressed: () {
          Navigator.pushNamed(context, "/foodCamera");
        },
        child: const Icon(LucideIcons.focus),
      ),
    );
  }
}


// GNav(
//           backgroundColor: Colors.white,
//           rippleColor: (Colors.green[200])!,
//           hoverColor: (Colors.green[200])!,
//           haptic: true,
//           selectedIndex: _currIndex,
//           onTabChange: _setSelectedIndex,
//           curve: Curves.easeIn,
//           gap: 5,
//           activeColor: Colors.white,
//           iconSize: 20,
//           style: GnavStyle.google,
//           tabBackgroundColor: const Color.fromRGBO(121, 187, 68, 0.8),
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//           tabMargin: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
//           tabs: const [
//             GButton(
//               icon: LucideIcons.home,
//               text: "Home",
//               textColor: Colors.white,
//             ),
//             GButton(
//               icon: LucideIcons.history,
//               text: "Riwayat",
//               textColor: Colors.white,
//             ),
//             GButton(
//               icon: LucideIcons.pencil,
//               text: "Akun",
//               textColor: Colors.white,
//             ),
//             GButton(
//               icon: LucideIcons.pencil,
//               text: "Splash",
//               textColor: Colors.white,
//             ),
//           ]),