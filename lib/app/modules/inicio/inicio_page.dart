import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_appbar.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/inicio/widgets/boton_pedirgas.dart';
import 'package:gasjm/app/modules/inicio/widgets/content_map.dart';
import 'package:get/get.dart';

//Pantalla de inicio del cliente
class InicioPage extends StatelessWidget {
  const InicioPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
      builder: (_) => Scaffold(
        //Menú deslizable a la izquierda con opciones del  usuario
        drawer: MenuLateral(),
        //Barra de herramientas de opciones para  agenda y  historial
        appBar: AppBar(
          backgroundColor: AppTheme.blueBackground,
          actions: const [MenuAppBar()],
          title: const Text('GasJ&M'),
        ),
        //Body
        body: SafeArea(
          bottom: false,
          child: Stack(children: const <Widget>[
            //Widget Mapa
            Positioned.fill(
              child: ContentMap(), 
            ),
            //

            //Widget Boton para pedir el gas
            BotonPedirGas(),
          ]),
        ),
      ),
    );
  }
}
