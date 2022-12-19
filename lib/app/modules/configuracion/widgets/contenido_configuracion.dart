import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/configuracion/configuracion_controller.dart';
import 'package:gasjm/app/modules/configuracion/widgets/item_configuracion.dart';
import 'package:get/get.dart';

class ContenidoConfiguracion extends StatelessWidget {
  ContenidoConfiguracion({Key? key}) : super(key: key);
  final ConfiguracionController _ = Get.put(ConfiguracionController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          //height: Responsive.hp(context),
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: const [ItemConfiguracion(nombreItem: "Notificaciones")],
          ),
        ),
      ],
    );
  }
}
