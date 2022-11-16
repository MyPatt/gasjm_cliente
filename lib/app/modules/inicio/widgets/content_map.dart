import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContentMap extends StatelessWidget {
  const ContentMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) => Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                     
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        height: Responsive.getScreenSize(context).height * .05,
                        width: Responsive.getScreenSize(context).width * .95,
                        child: TextFormField(
                          readOnly: true,
                          enabled: false,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              ?.copyWith(
                                  color: Color.fromARGB(96, 2, 1, 1),
                                  fontWeight: FontWeight.w400),
                          controller: _.direccionTextController,
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Obx(
                  () => _.posicionInicialCliente.value ==
                          const LatLng(-12.122711, -77.027475)
                      ? const Center(child: CircularProgressIndicator())
                      : GoogleMap(
                          mapType: MapType.normal,
                          markers: Set.of(_.marcadores),
                          initialCameraPosition: CameraPosition(
                              target: _.posicionInicialCliente.value,
                              zoom: 15.0),
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
                          onMapCreated: _.onMapaCreado,
                          onCameraMove: _.onCameraMove,
                          onCameraIdle: () async {
                            _.getMovimientoCamara();
                          },
                        ),
                ))
              ],
            ));
  }
}
//TODO: Boton para regresar a la ubicacion inicial