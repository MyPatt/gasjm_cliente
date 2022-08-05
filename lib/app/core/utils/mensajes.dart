import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:get/get.dart';

abstract class Mensajes {
  static void showToastBienvenido(String sms) {
    Fluttertoast.showToast(
        msg: sms,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppTheme.blueDark,
        textColor: Colors.white);
  }

  static void showGetSnackbar(
      {required String titulo, required String mensaje,Duration? duracion=const Duration(seconds: 3), Icon? icono}) {
    Get.snackbar(titulo, mensaje,
        backgroundColor: AppTheme.blueDark,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: duracion,
        borderRadius: 0,
        icon: icono);
  }
}
