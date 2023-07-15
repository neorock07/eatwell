import 'package:fluttertoast/fluttertoast.dart';

class Util {
  static void setToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }
}
