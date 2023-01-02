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
          () => _.cargandoDatosDelPedidoRealizado.value
              ? const Center(child: CircularProgress())
              : Stack(
                  children: [
                    //Widget de Mapa  para la vista previa de la ruta en tiempo real
                    Positioned.fill(
                        child: ContenidoMapa(
                      marcadores: _.marcadores,
                      target: _.posicionOrigenVehiculoRepartidor.value,
                      onMapCreated: (controller) => _.onMapaCreado(controller),
                      points: _.polylineCoordinates,
                    )),

                    //Boton para que el usuario cancele su pedido
                    BotonCancelar(
                        onPressed: () =>
                            //modal para confirmar si desea cancelar
                            showDialog(
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
                                                //en caso de confirmar se actualiza el estado como cancelado
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
