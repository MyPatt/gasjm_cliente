import 'package:flutter/material.dart'; 
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaWidget extends StatelessWidget {
  const MapaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = InicioController();
    //Evento en el marcker clic
    controller.onMarkerTap.listen((id) {
      print("solo por probar $id");
    });
    //
    return GetBuilder<InicioController>(
        builder: (_) => Expanded(
            child: Obx(
          () => _.posicionInicial.value ==
                  const LatLng(-0.2053476, -79.4894387)
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  markers: Set.of(_.markers),
                  onMapCreated: _.onMapaCreated,
                  initialCameraPosition: CameraPosition(
                      target: _.posicionInicial.value, zoom: 15),
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  onTap: _.onTap,
                ),
        )));
  }
}
//TODO: Boton para regresar a la ubicacion inicial