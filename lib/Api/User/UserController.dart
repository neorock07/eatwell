import 'dart:developer';
import 'dart:io';

import 'package:eatwell/Api/Jadwal/Jadwal.dart';
import 'package:eatwell/Api/Riwayat/Riwayat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class UserController {
  int? id;
  String? username;
  String? password;
  String? jenis_kelamin;
  int? tinggi;
  DateTime? lahir;
  double? berat;
  String? aktivitas;
  double? target_kalori;
  String? foto;
  Riwayat? riwayat;
  Jadwal? jadwal;
  String? message;
  bool? status;
  UserController(
      {this.id,
      this.username,
      this.password,
      this.jenis_kelamin,
      this.tinggi,
      this.lahir,
      this.berat,
      this.aktivitas,
      this.target_kalori,
      this.foto,
      this.riwayat,
      this.jadwal,
      this.message,
      this.status});

  factory UserController.getLogin(Map<String, dynamic> map) {
    return UserController(message: map["message"], status: map["status"]);
  }

  factory UserController.getAllData(Map<String, dynamic> map) {
    DateFormat? date = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ");
    DateTime? waktu;
    waktu = date.parse(map["lahir"].toString());
    return UserController(
        id: map['id'],
        username: map['username'],
        jenis_kelamin: map['jenis_kelamin'],
        tinggi: map['tinggi'],
        lahir: waktu,
        berat: map['berat'],
        aktivitas: map['aktivitas'],
        target_kalori: map['target_kalori']);
  }

  static Future<UserController> fromLogin(
      String? nama, String? password) async {
    String ip = "192.168.1.3";
    var url = Uri.http("$ip:8080", "/api/users/login");
    var jsonData;
    var body = jsonEncode({"nama": nama, "password": password});
    var headers = {"Content-Type": "application/json"};

    var connect = await http.post(url, headers: headers, body: body);

    if (connect.statusCode == 200) {
      jsonData = json.decode(connect.body) as Map<String, dynamic>;
      log("menerima login ");
    } else {
      log("tidak menerima respon login : ${connect.statusCode}");
    }
    return UserController.getLogin(jsonData);
  }

  static Future<bool?> fromRegister({
    String? nama,
    String? password,
    String? jenis_kelamin,
    DateTime? lahir,
    int? tinggi,
    int? berat,
    File? foto,
    String? aktivitas,
    double? target_kalori,
  }) async {
    String ip = "192.168.1.3";
    var url = Uri.parse("http://$ip:8080/api/users/register");

    var request = http.MultipartRequest('POST', url);
    bool respon;
    // Tambahkan data form
    request.fields['nama'] = nama!;
    request.fields['password'] = password!;
    request.fields['jenis_kelamin'] = jenis_kelamin!;
    request.fields['tinggi'] = tinggi.toString();
    request.fields['lahir'] = lahir.toString();
    request.fields['berat'] = berat.toString();
    request.fields['aktivitas'] = aktivitas!;
    request.fields['target_kalori'] = target_kalori.toString();

    // Tambahkan file foto
    if (foto != null) {
      var fotoStream = http.ByteStream(foto.openRead());
      var fotoLength = await foto.length();
      var multipartFile = http.MultipartFile('foto', fotoStream, fotoLength,
          filename: foto.path.split('/').last,
          contentType: MediaType('image', 'jpg'));
      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      respon = true;
      log("berhasil register");
    } else {
      respon = false;
      log("gagal register");
    }
    return respon;
  }

  static Future<int?> getIdByName(String? nama) async {
    String ip = "192.168.1.3";
    var url = Uri.parse("http://$ip:8080/api/users/username/${nama}");
    var response = await http.get(url);
    late var data;
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      log("id nya : $data");
      return data;
    }
    return null;
  }

  static Future<UserController> fromJson(String nama) async {
    String ip = "192.168.1.3";
    var url = Uri.parse("http://$ip:8080/api/users")
        .replace(queryParameters: {"nama": nama});
    var response = await http.get(url);
    late var data;
    if (response.statusCode == 200) {
      data = json.decode(response.body) as Map<String, dynamic>;
      log("data user berhasil di raih : ${data['lahir']}");
    } else {
      data = null;
      log("data user gagal di raih");
    }
    return UserController.getAllData(data);
  }
}
// id
// - nama
// - password
// - jenis_kelamin
// - tinggi
// - lahir
// - berat
// - aktivitas
// - target_kalori
// - foto
// - riwayat
// - jadwal