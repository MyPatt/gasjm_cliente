import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/local_widgets/boton_cancelar.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/local_widgets/contenido_mapa.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/estadopedido2_controller.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

//Pantalla   del cliente cuando su pedido se encuentra procesando
class EstadoPedido2Page extends StatelessWidget {
  const EstadoPedido2Page({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          // actions: const [ActionsProcesoPedido()],
          actions: <Widget>[
            IconButton(
                onPressed: () => Get.find<EstadoPedido2Controller>()
                    .cargarPaginaNotifiaciones(),
                icon: const Icon(Icons.notifications_none_outlined))
          ],
          title: const Text('Gas J&M'),
        ),
        //Body
        body: FutureBuilder(
            future: Get.find<EstadoPedido2Controller>()
                .cargarDatosDelPedidoRealizado(),
            builder: (context, AsyncSnapshot<LatLng> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: TextDescription(text: 'Espere un momento...'),
                );
              }
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    //Widget de Mapa  para la vista previa de la ruta en tiempo real
                    //  Positioned.fill(child: ContenidoMapa()),
                    Positioned(child: ContenidoMapa()),
                    //Boton para que el usuario cancele su pedido
                    const BotonCancelar()
                  ],
                );
              }
              print('-----${snapshot.data}');
              return const Center(
                child: CircularProgress(),
              );
            }));
  }
}
