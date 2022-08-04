import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/agenda/cliente/local_widgets/editar/editar_controller.dart';
import 'package:gasjm/app/modules/agenda/cliente/local_widgets/editar/editaragenda_form.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditarAgendaPage extends StatelessWidget {
  const EditarAgendaPage({Key? key}) : super(key: key);
  final initialCameraPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarAgendaController>(
        builder: (_) => Scaffold(
              appBar: AppBar(
                backgroundColor: AppTheme.blueBackground,
                elevation: 0.0,
                title: const Text("Agenda de pedidos"),
              ),
              backgroundColor: AppTheme.background,
              body: Stack(
                children: [
                  //Widget Mapa
                  Positioned.fill(
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      height: Responsive.getScreenSize(context).height * .40,
                      // child: const ContentMap()
                      child: GoogleMap(
                        // markers: controller.markers,
                        // onMapCreated: controller.onMapaCreated,
                        initialCameraPosition: initialCameraPosition,
                        myLocationButtonEnabled: false,
                        compassEnabled: false,
                        //  onTap: controller.onTap,
                      ),
                    ),
                  ),

                  //Widget Formulario para pedir el gas
                  const EditarAgendaForm(),
                ],
              ),
            ));
  }
}
