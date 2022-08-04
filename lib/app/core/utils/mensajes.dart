import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

abstract class Mensajes {
    static void showToastBienvenido(String sms) {
    Fluttertoast.showToast(
        msg: sms,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:AppTheme.blueDark,
        textColor: Colors.white);
  }
}