import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/configuracion/configuracion_controller.dart';
import 'package:gasjm/app/modules/configuracion/widgets/contenido_configuracion.dart';  
import 'package:get/get.dart';

class ConfiguracionPage extends StatelessWidget {
  const ConfiguracionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfiguracionController>(
        builder: (_) => Scaffold(
              backgroundColor: AppTheme.background,

              //
              appBar: AppBar(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                backgroundColor: AppTheme.blueBackground,
                automaticallyImplyLeading: true,
                title: const Text("Configuración"),
              ),
              body:   
                      const ContenidoConfiguracion()
                 ));
  }
}
