import 'package:flutter/material.dart';

class TextDescription extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  const TextDescription(
      {Key? key,
      required this.text,
      this.color = Colors.black38,
      this.textAlign = TextAlign.center})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          ?.copyWith(color: color, fontWeight: FontWeight.w400),
      maxLines: 3,
    );
  }
}
