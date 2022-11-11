import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/perfil/widgets/form_usuario.dart';
import 'package:gasjm/app/modules/perfil/widgets/imagen_usuario.dart';

class PerfilUsuario extends StatelessWidget {
  const PerfilUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
      child: ListView(
        children: [
          SizedBox(
            height: 870.00,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // double innerHeight = constraints.maxHeight;
                //   double innerWidth = constraints.maxWidth;
                return Stack(
                  //fit: StackFit.expand,
                  children:  <Widget>[
                    const Positioned(
                        bottom: 0, left: 0, right: 0, child: FormUsuario()),
                    Positioned(
                        top: 0, left: 0, right: 0, child: ImagenUsuario()),
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
