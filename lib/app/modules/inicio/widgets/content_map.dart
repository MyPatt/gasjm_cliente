import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContentMap extends StatelessWidget {
  const ContentMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = InicioController();
    //Evento en el marcker clic
    controller.onMarkerTap.listen((id) {
      print("solo por probar $id");
    });
    //
    print("${controller.servicioHbilitado.value}");
    return GetBuilder<InicioController>(
        builder: (_) => Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          height:
                              Responsive.getScreenSize(context).height * .05,
                          width: Responsive.getScreenSize(context).width * .95,
                          child: Obx(
                            () {
                              return TextDescription(
                                text: _.direccion.value,
                                textAlign: TextAlign.left,
                              );
                            },
                          )),
                    ),
                  ],
                ),
                Expanded(
                    child: Obx(
                  () => _.posicionInicial.value ==
                          const LatLng(-0.2053476, -79.4894387)
                      ? const Center(child: CircularProgressIndicator())
                      : GoogleMap(
                          markers: Set.of(_.markers),
                          onMapCreated: _.onMapaCreated,
                          initialCameraPosition: CameraPosition(
                              target: _.posicionInicial.value, zoom: 15),
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
                          onTap: _.onTap,
                          //TODO: onCameraMove: https://stackoverflow.com/questions/53652573/fix-google-map-marker-in-center
                        ),
                ))
              ],
            ));
  }
}
//TODO: Boton para regresar a la ubicacion inicial