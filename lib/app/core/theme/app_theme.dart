import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color.fromRGBO(240, 241, 248, 1.0);
  static const Color blueDark = Color(0xFF143656);
  static const Color blue = Color(0xFF13497B);
  static const Color blueOpacity = Color(0xFF225C92);
  static const Color blueLight = Color(0xFF497FAF);
  static const Color cyan = Color(0xFF33BFC8);
  static const Color searchColor = Color(0xFF7192B0);
  static const Color light = Color.fromRGBO(168, 174, 196, 1.0);
  //static const Color light = Color.fromARGB(255, 219, 221, 229);

  static const Color blueBackground = Color.fromRGBO(33, 116, 212, 1.0);

  static List<Color> blueGradients = [blueBackground, blueDark];
  //Tema para  fechas en el calendario
  static final lightTemaCalendario = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: blueBackground,
      brightness: Brightness.light);
  static final darkTemaCalendario = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: blueDark,
      brightness: Brightness.dark);
}
