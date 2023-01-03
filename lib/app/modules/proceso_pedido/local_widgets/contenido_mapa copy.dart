import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContenidoMapa extends StatelessWidget {
  ContenidoMapa(
      {Key? key,
      required this.marcadores,
      required this.target,
      required this.onMapCreated,
      required this.points})
      : super(key: key);
  final Iterable<Marker> marcadores;
  final LatLng target;
  final Function(GoogleMapController)? onMapCreated;
  final List<LatLng> points;

  final _ = Get.put(ProcesoPedidoController());
  @override
  Widget build(BuildContext context) {
    //return Column(    children: const <Widget>[NotificacionEstado(), MapaWidget()],   );
    return Column(
      children: [
        Expanded(
            child: Obx(
          () => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_.posicionOrigenVehiculoRepartidor.value.latitude,
                  _.posicionOrigenVehiculoRepartidor.value.longitude),
              zoom: 15,
            ),
            markers: {
              Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: _.currentLocationIcon,
                  position: LatLng(
                      _.posicionOrigenVehiculoRepartidor.value.latitude,
                      _.posicionOrigenVehiculoRepartidor.value.longitude),
                  rotation: _.rotacionMarcadorVehiculoRepartidor.value),
              Marker(
                  markerId: MarkerId("source"),
                  icon: _.iconoOrigenMarcadorVehiculoRepartidor,
                  position: _.posicionOrigenVehiculoRepartidor.value,
                  rotation: _.rotacionMarcadorVehiculoRepartidor.value),
              Marker(
                markerId: MarkerId("destination"),
                icon: _.iconoDestinoMarcadorPedidoCliente,
                position: _.posicionDestinoPedidoCliente.value,
              ),
            },
            onMapCreated: (controller) => _.onMapaCreado(controller),
            polylines: {
              Polyline(
                polylineId: const PolylineId("ruta"),
                points: _.polylineCoordinates,
                color: AppTheme.blueBackground,
                width: 3,
              ),
            },

            /* GoogleMap(
              markers: Set.of(marcadores),
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(target: target, zoom: 15),
              myLocationButtonEnabled: true,
              compassEnabled: false,
                      ),*/
          ),
        )),
      ],
    );
  }
}
