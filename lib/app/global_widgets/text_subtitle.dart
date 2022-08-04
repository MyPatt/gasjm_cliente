import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/theme/text_theme.dart';

class TextSubtitle extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextStyle? style;

  const TextSubtitle(
      {Key? key,
      required this.text,
      this.color = AppTheme.blueDark,
      this.textAlign,
      this.style = TextoTheme.subtitleStyle1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    );
  }
}
