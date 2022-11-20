import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/actions_proceso_pedido.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/cliente/menu_appbar.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/boton_cancelar.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/contenido_mapa.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/contenido_pedido.dart';
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
        backgroundColor: AppTheme.background,
        //Menú deslizable a la izquierda con opciones del  usuario
        //drawer: MenuLateral(imagenPerfil: _.imagenUsuario),
        //Barra de herramientas de opciones para  agenda y  historial
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: AppTheme.blueBackground,
          actions: const [ActionsProcesoPedido()],
          title: const Text('Gas J&M'),
        ),
        //Body
        body: Obx(
          () => _.cargandoPedidos.value
              ? const Center(child: CircularProgress())
              : Stack(
                  children: [
                    //Widget Mapa
                    Positioned.fill(
                        child: Column(
                      children: <Widget>[
                        Obx(() => ContenidoPedido(pedido: _.pedido.value)),
                        const ContenidoMapa()
                      ],
                    )),

                    //
                    BotonCancelar(onPressed: () => _.cancelarPedido())
                  ],
                ),
        ),
      ),
    );
  }
}
