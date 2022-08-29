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
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400),
                          controller: _.locationController,
                          keyboardType: TextInputType.none,
                          decoration: InputDecoration(

                              /*   prefixIcon: Icon(
                                Icons.pin_drop_outlined,
                                color: Colors.black26,
                              ),*/
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        /* child: Obx(
                            () {
                              return TextDescription(
                                text: _.direccion.value,
                                textAlign: TextAlign.left,
                              );
                            },
                          )*/
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Obx(
                  () =>
                      _.initialPos.value == const LatLng(-12.122711, -77.027475)
                          ? const Center(child: CircularProgressIndicator())
                          : GoogleMap(
                              mapType: MapType.normal,
                              markers: Set.of(_.marcador),
                              initialCameraPosition: CameraPosition(
                                  target: _.initialPos.value, zoom: 15.0),
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
                              onMapCreated: _.onCreated,
                              onCameraMove: _.onCameraMove,
                              /*
                          oncameramoveendltng= await pickLocationOnMap(positio)

                          */
                              onCameraIdle: () async {
                                _.getMoveCamera();
                                //getPinnAddress
                              },
                            ),
                  /*
GoogleMap(
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
                      */
                ))
              ],
            ));
  }
}
//TODO: Boton para regresar a la ubicacion inicial