import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/pedido/local_widgets/boton_cancelar.dart';
import 'package:gasjm/app/modules/pedido/local_widgets/contenido_mapa.dart';
import 'package:gasjm/app/modules/pedido/local_widgets/dropdown_notificacion.dart';
import 'package:gasjm/app/modules/pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';

//Pantalla   del cliente cuando su pedido se encuentra procesando
class ProcesoPedidoPage extends StatelessWidget {
  const ProcesoPedidoPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 226, 227, 1),
      //Menú deslizable a la izquierda con opciones del  usuario
      drawer: const MenuLateral(),
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

        // actions: const [ActionsProcesoPedido()],
        actions: const <Widget>[
          PopuMenuNotificacion(),
        ],
        title: const Text('Gas J&M'),
      ),
      //Body
      body: Obx(
        () => Get.find<ProcesoPedidoController>()
                .cargandoDatosDelPedidoRealizado
                .value
            ? const Center(child: CircularProgress())
            : Stack(
                children: [
                  //Widget de Mapa  para la vista previa de la ruta en tiempo real
                  //  Positioned.fill(child: ContenidoMapa()),
                  Positioned(child: ContenidoMapa()),
                  //Boton para que el usuario cancele su pedido
                  const BotonCancelar()
                ],
              ),
      ),
    );
  }
}
