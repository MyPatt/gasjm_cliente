import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/boton_cancelar.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/contenido_mapa.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/contenido_pedido.dart';
import 'package:gasjm/app/modules/proceso_pedido/local_widgets/dropdown_notificacion.dart';
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
import 'package:gasjm/app/core/utils/globals.dart' as globals;
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
          // actions: const [ActionsProcesoPedido()],
          actions: <Widget>[
            /*  IconButton(
                onPressed: () {
                 // globals.existeNotificacion.value = false;
                 _.cargarListaNotificaciones();
                print(_.notificaciones.length);
                },
                icon: Obx(
                  () => Icon(globals.existeNotificacion.value
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_none_outlined),
                )),*/
            Obx(
              () => PopuMenuNotificacion(
                  icono: (Icon(globals.existeNotificacion.value
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_none_outlined))),
            ),
          ],
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
                      children: const <Widget>[
                        //    Obx(() => ContenidoPedido(pedido: _.pedido.value)),
                        ContenidoMapa()
                      ],
                    )),
                    Positioned(
                      top: 5,
                      left: 15,
                      child: Obx(() => ContenidoPedido(pedido: _.pedido.value)),
                    ),
                    //
                    BotonCancelar(
                        onPressed: () => showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return //Obx
                                    (
                                        //() =>
                                        ModalAlert(
                                            titulo: 'Cancelar pedido',
                                            mensaje:
                                                '¿Está seguro de cancelar su pedido?',
                                            icono: Icons.cancel_outlined,
                                            onPressed: () =>
                                                _.actualizarEstadoPedido(
                                                    _.pedido.value.idPedido!)));
                              },
                            ))
                  ],
                ),
        ),
      ),
    );
  }
}
