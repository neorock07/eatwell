import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Eat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "swash",
                            fontSize: 38,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Well",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "swash",
                            fontSize: 38,
                            color: Color.fromRGBO(121, 187, 68, 0.8),
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                Image.asset(
                  'assets/images/splashlogo.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.center,
                ),
              ],
            ),
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
                      onTap: () {
                        Navigator.pushNamed(context, "/loginPage");
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
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey,
                      hoverColor: Colors.grey,
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
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
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
