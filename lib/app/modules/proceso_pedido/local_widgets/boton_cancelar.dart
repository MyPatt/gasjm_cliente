import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';

class BotonCancelar extends StatelessWidget {
  const BotonCancelar({Key? key, required this.onPressed}) : super(key: key);
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: kBottomNavigationBarHeight * 1.1,
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            decoration: BoxDecoration(
              color: AppTheme.blueBackground,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: PrimaryButton(texto: "Cancelar", onPressed: onPressed)));
  }
}
