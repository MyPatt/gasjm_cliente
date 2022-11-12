import 'package:flutter/material.dart'; 
import 'package:gasjm/app/core/theme/text_theme.dart';

class TextSubtitle extends StatelessWidget {
  final String text;
 
  final TextAlign? textAlign;
  final TextStyle? style;

  const TextSubtitle(
      {Key? key,
      required this.text, 
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
