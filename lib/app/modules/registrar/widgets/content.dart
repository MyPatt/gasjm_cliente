import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/registrar/widgets/form_registrar.dart';

class Contenido extends StatelessWidget {
  const Contenido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const FormRegistrar());
  }
}
