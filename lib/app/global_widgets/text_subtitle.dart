import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class TextSubtitle extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  //final TextStyle? style;

  const TextSubtitle({
    Key? key,
    required this.text,
    this.color = AppTheme.blueDark,
    this.textAlign = TextAlign.center,
    //this.style = TextoTheme.subtitleStyle1
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(color: color, fontWeight: FontWeight.w700),
    );
  }
}
