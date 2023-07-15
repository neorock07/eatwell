import 'dart:developer';

import 'package:eatwell/Api/User/UserController.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _minPass = 8;
  TextEditingController _passController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  bool _passVal = true;
  bool passVisible = true;
  // @override
  // void initState() {
  //   super.initState();
  //   _passController = TextEditingController();
  // }

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  void _validatePassword(String value) {
    setState(() {
      _passVal = value.length >= _minPass;
    });
  }

  UserController? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Eat",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "swash",
                                      fontSize: 38,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              const Text(
                                "Well",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "swash",
                                    fontSize: 38,
                                    color: Color.fromRGBO(121, 187, 68, 0.8),
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Selamat Datang",
                            style: TextStyle(
                                fontFamily: "philo",
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Selamat Bergabung",
                            style: TextStyle(
                                fontFamily: "philo",
                                fontSize: 23,
                                color: Colors.lightGreen),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: _userController,
                      decoration: InputDecoration(
                          label: const Text("Username"),
                          prefixIcon: const Icon(LucideIcons.userCheck),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(10))),
                      autofocus: true,
                      autocorrect: true,
                      cursorColor: Colors.green,
                      style: const TextStyle(fontFamily: "philo", fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextField(
                      controller: _passController,
                      obscureText: passVisible,
                      onChanged: _validatePassword,
                      decoration: InputDecoration(
                          errorText: !_passVal ? "at least 8 characters" : null,
                          label: const Text("Password"),
                          prefixIcon: const Icon(LucideIcons.key),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passVisible = !passVisible;
                                });
                              },
                              icon: Icon(passVisible
                                  ? LucideIcons.eye
                                  : LucideIcons.eyeOff)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(10))),
                      autofocus: true,
                      autocorrect: true,
                      cursorColor: Colors.green,
                      style: const TextStyle(fontFamily: "philo", fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
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
                        onTap: () async {
                          UserController.fromLogin(
                                  _userController.text.toString(),
                                  _passController.text.toString())
                              .then((value) {
                            user = value;
                          });

                          if (_passVal && user?.status == true) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'username', _userController.text.toString());
                            prefs.setString(
                                'password', _passController.text.toString());
                            Navigator.pushNamed(context, '/');
                            log("Masuk  : $_userController.text.toString()");
                          } else {
                            log("tidak boleh masuk");
                          }
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
                              "Sign in",
                              style: TextStyle(
                                  fontFamily: "swash",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: const Text(
                        "Register now!",
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
