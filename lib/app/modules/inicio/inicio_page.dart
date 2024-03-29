import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart'; 
import 'package:gasjm/app/global_widgets/cliente/menu_appbar.dart';

import 'package:gasjm/app/global_widgets/menu_lateral.dart'; 
import 'package:gasjm/app/modules/inicio/widgets/boton_pedirgas.dart';
import 'package:gasjm/app/modules/inicio/widgets/content_map.dart';
 

//Pantalla de inicio del cliente
class InicioPage extends StatelessWidget {
  const InicioPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        backgroundColor: AppTheme.background,
        //Menú deslizable a la izquierda con opciones del  usuario
        drawer: const MenuLateral(),
        //Barra de herramientas de opciones para  agenda y  historial
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
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
   
    );
  }
}
