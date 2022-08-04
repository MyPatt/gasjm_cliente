import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class TextoTheme {
  //Estilos de  textos
  static const TextStyle headingStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.blueDark);
  static const TextStyle subHeadingStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.light);
  //
  static const TextStyle subtitleStyle1 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
      color: AppTheme.blueDark);
  static const TextStyle subtitleStyle2 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.15,
      color: AppTheme.blueDark);
  //Theme.of(context).textTheme.headline4?.copyWith(   color: AppTheme.blue, fontWeight: FontWeight.w900)
}
