import 'dart:developer';
import 'dart:io';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:eatwell/Api/User/UserController.dart';
import 'package:eatwell/Partial/Util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _tinggiController = TextEditingController();
  TextEditingController _beratController = TextEditingController();
  TextEditingController _kaloriController = TextEditingController();
  TextEditingController _lahirController = TextEditingController();
  bool _passVal = true;
  final _minPass = 8;
  bool passVisible = true;
  bool isNum = true;
  bool isNum2 = true;
  bool isNum3 = true;
  String? aktivitas;
  UserController? user;
  DateTime? _selectDate;
  String? jenis_kelaminControl;
  String? aktivitasControl;
  bool? canLogin;

  @override
  void dispose() {
    _passController.dispose();
    _userController.dispose();
    _tinggiController.dispose();
    _kaloriController.dispose();
    super.dispose();
  }

  void _validatePassword(String value) {
    setState(() {
      _passVal = value.length >= _minPass;
    });
  }

  void _isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    setState(() {
      isNum = numericRegex.hasMatch(str);
    });
  }

  void _isNumeric2(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    setState(() {
      isNum2 = numericRegex.hasMatch(str);
    });
  }

  void _isNumeric3(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    setState(() {
      isNum3 = numericRegex.hasMatch(str);
    });
  }

  List<String> itemAktivitas = ["Jarang", "Sedang", "Tinggi"];
  File? _imageG;

  Future getImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (picked != null) {
        _imageG = File(picked.path);
      } else {
        log("No image selected");
      }
    });
  }

  Future<void> _selectDatePick(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != _selectDate) {
      setState(() {
        _selectDate = pickedDate;
        _lahirController.text = _selectDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 157, 204, 94),
        title: const Text(
          "Isi dulu yuk!",
          style:
              TextStyle(fontFamily: "philo", fontSize: 19, color: Colors.black),
        ),
      ),
      backgroundColor: const Color.fromRGBO(225, 238, 208, 1),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: InkWell(
                  onTap: getImage,
                  child: Container(
                      child: _imageG == null
                          ? Image.asset("assets/images/profile.png")
                          : Image.file(_imageG!)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                      label: const Text("Username"),
                      prefixIcon: const Icon(LucideIcons.userCheck),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10))),
                  autofocus: true,
                  autocorrect: true,
                  cursorColor: Colors.green,
                  style: const TextStyle(fontFamily: "philo", fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
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
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10))),
                  autofocus: true,
                  autocorrect: true,
                  cursorColor: Colors.green,
                  style: const TextStyle(fontFamily: "philo", fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        onChanged: _isNumeric,
                        keyboardType: TextInputType.number,
                        controller: _tinggiController,
                        decoration: InputDecoration(
                            errorText: !isNum ? "invalid character" : null,
                            label: const Text("Tinggi Badan (cm)"),
                            prefixIcon: const Icon(LucideIcons.ruler),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 2),
                                borderRadius: BorderRadius.circular(10))),
                        autofocus: true,
                        autocorrect: true,
                        cursorColor: Colors.green,
                        style:
                            const TextStyle(fontFamily: "philo", fontSize: 15),
                      ),
                    ),
                    InkWell(
                      onTap: () => _selectDatePick(context),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          enabled: false,
                          controller: _lahirController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              label: const Text("Kelahiran"),
                              prefixIcon: const Icon(LucideIcons.calendar),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2),
                                  borderRadius: BorderRadius.circular(10))),
                          autofocus: true,
                          autocorrect: true,
                          cursorColor: Colors.green,
                          style: const TextStyle(
                              fontFamily: "philo", fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  onChanged: _isNumeric2,
                  keyboardType: TextInputType.number,
                  controller: _beratController,
                  decoration: InputDecoration(
                      errorText: !isNum2 ? "invalid character" : null,
                      label: const Text("Berat Badan (kg)"),
                      prefixIcon: const Icon(LucideIcons.gauge),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10))),
                  autofocus: true,
                  autocorrect: true,
                  cursorColor: Colors.green,
                  style: const TextStyle(fontFamily: "philo", fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: CustomRadioButton(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.15,
                    buttonLables: const ["Laki-Laki", "Perempuan"],
                    buttonValues: const ["L", "P"],
                    radioButtonValue: (value) {
                      jenis_kelaminControl = value;
                      log("Value : $value");
                    },
                    buttonTextStyle: const ButtonTextStyle(
                      textStyle: TextStyle(fontFamily: "philo", fontSize: 15),
                    ),
                    unSelectedColor: Colors.grey[200]!,
                    selectedColor: Colors.lightGreen),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: DropdownButtonFormField<String>(
                  value: aktivitas,
                  onChanged: (String? newValue) {
                    setState(() {
                      aktivitas = newValue;
                    });
                  },
                  items: itemAktivitas
                      .map<DropdownMenuItem<String>>((String value) {
                    aktivitasControl = value;
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Tingkat Aktivitas Fisik',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: TextField(
                  onChanged: _isNumeric3,
                  keyboardType: TextInputType.number,
                  controller: _kaloriController,
                  decoration: InputDecoration(
                      errorText: !isNum3 ? "invalid character" : null,
                      label: const Text("Target Kalori (kkal)"),
                      prefixIcon: const Icon(LucideIcons.flame),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2),
                          borderRadius: BorderRadius.circular(10))),
                  autofocus: true,
                  autocorrect: true,
                  cursorColor: Colors.green,
                  style: const TextStyle(fontFamily: "philo", fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.4,
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
                        UserController.fromRegister(
                                nama: _userController.text.toString(),
                                password: _passController.text.toString(),
                                tinggi: int.parse(
                                    _tinggiController.text.toString()),
                                lahir: _selectDate,
                                foto: _imageG,
                                berat:
                                    int.parse(_beratController.text.toString()),
                                jenis_kelamin: jenis_kelaminControl,
                                aktivitas: aktivitasControl,
                                target_kalori: double.parse(
                                    _kaloriController.text.toString()))
                            .then((value) {
                          canLogin = value;
                          setState(() {});
                        });
                        Navigator.pushNamed(context, "/loginPage");
                        log("data register tersimpan");

                        Util.setToast("Berhasil Registrasi!");
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
                            "Simpan",
                            style: TextStyle(
                                fontFamily: "swash",
                                fontSize: 15,
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
        ),
      ),
    );
  }
}
