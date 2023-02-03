import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/identificacion/widgets/form_identificacion.dart';

class Contenido extends StatelessWidget {
  const Contenido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const FormIdentificacion()),
      ), 
    ]);
  }
}
