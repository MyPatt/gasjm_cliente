import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/modules/perfil/perfil_controller.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormDireccion extends StatelessWidget {
  const FormDireccion({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerfilController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: AppTheme.blueBackground,
          title: const Text('Dirección'),
        ),
        body: SafeArea(
          bottom: false,
          child: Stack(children: <Widget>[
            //Widget Mapa
            Positioned.fill(
                child: Column(
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
                          controller: _.direccionAuxTextoController,
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
                    child: FutureBuilder(
                  future: _.agregarMarcadorCliente(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Obx(() => GoogleMap(
                            mapType: MapType.normal,
                            markers: Set.of(_.marcadores),
                            initialCameraPosition: CameraPosition(
                                /*  target: LatLng(
                                    _.usuario.direccionPersona?.latitud ?? 0,
                                    _.usuario.direccionPersona?.longitud ?? 0)*/
                                target: _.posicionAuxCliente.value,
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
                          ));
                    } else {
                      return const CircularProgress();
                    }
                  },
                ))
              ],
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: PrimaryButton(
                        texto: "Seleccionar",
                        onPressed: () => _.seleccionarNuevaDireccion())))
          ]),
          //
        ),
      ),
    );
  }
}
