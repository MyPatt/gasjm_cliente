import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/contenido.dart';
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';

//Pantalla   del cliente cuando su pedido se encuentra procesando
class ProcesoPedidoPage extends StatelessWidget {
  const ProcesoPedidoPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProcesoPedidoController>(
      builder: (_) => Scaffold(
        //Menú deslizable a la izquierda con opciones del  usuario
        drawer: MenuLateral(imagenPerfil: _.imagenUsuario),
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
        body: Stack(
          children: [
            //Widget Mapa
            Positioned.fill(
              child: SizedBox(
                  height: Responsive.getScreenSize(context).height * .50,
                  child: const ContenidoProcesoPedido()),
            ),
            //
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: kBottomNavigationBarHeight * 1.1,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    decoration: BoxDecoration(
                      color: AppTheme.blueBackground,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: PrimaryButton(texto: "Cancelar", onPressed: () {})))
          ],
        ),
      ),
    );
  }
}
