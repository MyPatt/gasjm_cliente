import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/pedido/local_widgets/boton_cancelar.dart';
import 'package:gasjm/app/modules/pedido/local_widgets/contenido_mapa.dart';
import 'package:gasjm/app/modules/pedido/proceso_pedido_controller.dart';
import 'package:gasjm/app/modules/pedido/local_widgets/local_notice_service.dart';
import 'package:get/get.dart';

//Pantalla   del cliente cuando su pedido se encuentra procesando
class ProcesoPedidoPage extends StatelessWidget {
  const ProcesoPedidoPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 226, 227, 1),
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

        // actions: const [ActionsProcesoPedido()],
        actions: <Widget>[
          IconButton(
              onPressed: () => Noti.showBigTextNotification(
                  title: "New message title", body: "Your long body"),
              icon: const Icon(Icons.filter_alt_outlined)), IconButton(
              onPressed: () =>Get.find<ProcesoPedidoController>().showNotification(),
              icon: const Icon(Icons.filter_vintage_outlined)),
          IconButton(
              onPressed: () => Get.find<ProcesoPedidoController>()
                  .cargarPaginaNotifiaciones(),
              icon: Obx(() => Get.find<ProcesoPedidoController>()
                      .cargandoDatosDelPedidoRealizado
                      .value
                  ? const Icon(Icons.notifications_none_outlined)
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('notificacion')
                          // .doc('5jvaOHl0jt8Gz1sZKlTB')
                          .where('idPedidoNotificacion',
                              isEqualTo:
                                  //'6kqZh8vmKPuTKlAzKdnT'
                                  Get.find<ProcesoPedidoController>()
                                      .pedido
                                      .value
                                      .idPedido)
                          .orderBy("fechaNotificacion", descending: true)
                          .snapshots(),
                      // Get.find<ProcesoPedidoController>().getNotificacion(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child:
                                TextDescription(text: 'Espere un momento...'),
                          );
                        }
                        if (snapshot.hasData) {
                          print(Get.find<ProcesoPedidoController>()
                              .pedido
                              .value
                              .idPedido);

                          ///   print(Get.find<ProcesoPedidoController>().idPedido);
                          print('''''``````````````````````````````''' '');
                          print(snapshot.data?.docs.length);
                          Noti.showBigTextNotification(
                              title: "New message title",
                              body: "Your long body");
                          return const Icon(
                              Icons.notifications_active_outlined);
                        }

                        return const Icon(Icons.notifications_none_outlined);
                      })))
          /*    IconButton(
              onPressed: () => Get.find<ProcesoPedidoController>()
                  .cargarPaginaNotifiaciones(),
              icon: Obx(() => (Icon(globals.existeNotificacion.value
                  ? Icons.notifications_active_outlined
                  : Icons.notifications_none_outlined))))*/
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
