
import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContenidoMapa extends StatelessWidget {
  const ContenidoMapa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Column(    children: const <Widget>[NotificacionEstado(), MapaWidget()],   );
    return GetBuilder<ProcesoPedidoController>(
        builder: (_) => Expanded(
                child: Obx(
              () =>
              /* _.posicionCliente.value ==
                      const LatLng(-0.2053476, -79.4894387)
                  ? const Center(child: CircularProgress())
                  : */
                  GoogleMap(
                      markers: Set.of(_.marcadores),
                      onMapCreated: _.onMapaCreado,
                      initialCameraPosition: CameraPosition(
                          target: _.posicionCliente.value, zoom: 15),
                      myLocationButtonEnabled: true,
                      compassEnabled: false,
                      
                    ),
            )));
  }
}
