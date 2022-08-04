import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  PrimaryButton({
    required this.texto,
    required this.onPressed,
  });

  final void Function() onPressed;
  final String texto;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppTheme.blueBackground,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 60.0,
        //onPressed: () {},
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            texto,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
