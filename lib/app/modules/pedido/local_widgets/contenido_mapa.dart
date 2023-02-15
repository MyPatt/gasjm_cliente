import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/pedido/local_widgets/contenido_pedido.dart';
import 'package:gasjm/app/modules/pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContenidoMapa extends StatelessWidget {
  ContenidoMapa({
    Key? key,
  }) : super(key: key);

  final _ = Get.put(ProcesoPedidoController());
  @override
  Widget build(BuildContext context) {
    //return Column(    children: const <Widget>[NotificacionEstado(), MapaWidget()],   );
    return Column(
      children: [
        const ContenidoPedido(),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ubicacionRepartidor')
                    //   .doc('IXvTa9j5pZbYjpC0Ttgh0OXNcCD3')
                    // .doc(_.pedido.value.idRepartidor)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: TextDescription(text: 'Espere un momento...'),
                    );
                  }
                  if (snapshot.hasData) {
                    //
                    //
                    var markerId2 = const MarkerId('MarcadorPedidoCliente');
                    final marker2 = Marker(
                        markerId: markerId2,
                        position: LatLng(
                            _.posicionDestinoPedidoCliente.value.latitude,
                            _.posicionDestinoPedidoCliente.value.longitude),
                        icon: _.iconoDestinoMarcadorPedidoCliente);
               
                    // print(_posicionDestinoCliente.value.latitude);
                    _.marcadoresAux[markerId2] = marker2;

                    //
                    for (var repartidor in snapshot.data!.docs) {
                      var markerId = MarkerId(repartidor.id);
//
                      Direccion ubicacionActualRepartidor =
                          Direccion.fromMap(repartidor.get("ubicacionActual"));
                      //
                      double rotacionActualRepartidor =
                          (repartidor.get("rotacionActual"));
 
                      //
                      final marker = Marker(
                        markerId: markerId,
                        position: LatLng(ubicacionActualRepartidor.latitud,
                            ubicacionActualRepartidor.longitud),
                        rotation: rotacionActualRepartidor,
                        icon: _.iconoOrigenMarcadorVehiculoRepartidor,
                      );

                      //

                      _.marcadoresAux[markerId] = marker;

                      //Asignar
                      _.posicionOrigenVehiculoRepartidor.value = LatLng(
                          ubicacionActualRepartidor.latitud,
                          ubicacionActualRepartidor.longitud);
                    }

                    //
                    return GoogleMap(
                      myLocationButtonEnabled: true,
                      compassEnabled: true,
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      mapToolbarEnabled: false,
                      trafficEnabled: false,
                      tiltGesturesEnabled: false,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: false,
                      myLocationEnabled: true,
                      liteModeEnabled: false,
                      indoorViewEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            _.posicionDestinoPedidoCliente.value.latitude,
                            _.posicionDestinoPedidoCliente.value.longitude),
                        zoom: 15,
                      ),
                      markers: Set.of(_.marcadores),
                      onMapCreated: (controller) => _.onMapaCreado(controller),
                    );
                  }
                  //
                  return const Center(
                    child: CircularProgress(),
                  );
                })),
      ],
    );
  }
}
