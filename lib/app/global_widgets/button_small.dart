import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class ButtonSmall extends StatelessWidget {
  const ButtonSmall(
      {Key? key, required this.texto,
      required this.onPressed,
      this.width = 145,
      this.color = AppTheme.blueBackground}) : super(key: key);
  final void Function() onPressed;
  final String texto;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(
        
          borderRadius: BorderRadius.circular(15.0),
        ),
        onPressed: onPressed,
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
