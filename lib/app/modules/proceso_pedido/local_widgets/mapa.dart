import 'package:flutter/material.dart'; 

class MapaWidget extends StatelessWidget {
  const MapaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return Expanded(child: Container());
 /*
    return GetBuilder<InicioController>(
        builder: (_) => Expanded(
                child: Obx(
              () => _.posicionInicial.value ==
                      const LatLng(-0.2053476, -79.4894387)
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      markers: Set.of(_.marcadores),
                      onMapCreated: _.onMapaCreated,
                      initialCameraPosition: CameraPosition(
                          target: _.posicionInicial.value, zoom: 15),
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      onTap: _.onTap,
                    ),
            )));*/
  }
}
//TODO: Boton para regresar a la ubicacion inicial