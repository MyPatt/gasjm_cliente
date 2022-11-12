import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  
  const PrimaryButton({Key? key, 
    required this.texto,
    required this.onPressed,
  }) : super(key: key);

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
