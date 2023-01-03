import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
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
        Expanded(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ubicacionRepartidor')
                    .doc('IXvTa9j5pZbYjpC0Ttgh0OXNcCD3')
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    //
                    Direccion ubicacionActualRepartidor = Direccion.fromMap(
                        snapshot.data?.get("ubicacionActual"));

                    //

                    _.posicionOrigenVehiculoRepartidor.value = LatLng(
                        ubicacionActualRepartidor.latitud,
                        ubicacionActualRepartidor.longitud);

                    //

                    //
                    final cameraUpdate = CameraUpdate.newLatLng(
                      _.posicionOrigenVehiculoRepartidor.value,
                    );
                    _.controladorGoogleMap?.animateCamera(cameraUpdate);

                    //
                    return GoogleMap(
                       
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            _.posicionOrigenVehiculoRepartidor.value.latitude,
                            _.posicionOrigenVehiculoRepartidor.value.longitude),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                            markerId:
                                MarkerId("OrigenMarcadorVehiculoRepartidor"),
                            icon: _.iconoOrigenMarcadorVehiculoRepartidor,
                            position: _.posicionOrigenVehiculoRepartidor.value,
                            rotation:
                                _.rotacionMarcadorVehiculoRepartidor.value),
                        Marker(
                          markerId: MarkerId("DestinoMarcadorPedidoCliente"),
                          icon: _.iconoDestinoMarcadorPedidoCliente,
                          position: _.posicionDestinoPedidoCliente.value,
                        ),
                      },
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
