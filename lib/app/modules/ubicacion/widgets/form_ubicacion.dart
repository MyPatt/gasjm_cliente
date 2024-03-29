import 'package:flutter/material.dart'; 
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart'; 
import 'package:gasjm/app/modules/ubicacion/ubicacion_controller.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

class FormUbicacion extends StatelessWidget {
  const FormUbicacion({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: EdgeInsets.only(bottom: constraint.maxHeight * .1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                  height: 96,
                  child: Image(
                    image: AssetImage("assets/icons/gps.png"),
                  )),
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              Text(
                "Permiso de ubicación",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                    color: AppTheme.blue, fontWeight: FontWeight.w900),
              ),
              Text(
                "Esta aplicación requiere el permiso de ubicación para funcionar correctamente.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: Colors.black38, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              GetBuilder<UbicacionController>(
                builder: (_) => Obx(() {
                  //Mientras se ejecute el evento del button se muestra el circular progress
                  final estado = _.cargando.value;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Visibility(
                        visible: !_.cargando.value,
                        child: PrimaryButton(
                          texto: "Permitir",
                          onPressed: () async {
                            await Future.delayed(const Duration(seconds: 1));

                            try {
                              _.cargando.value = true;
                              var aux = await _.askGpsAccess();
                              switch (aux) {
                                case true:
                                  Get.toNamed(AppRoutes.identificacion);
                                  break;
                                default:
                              }
                            } catch (e) {
                              Mensajes.showGetSnackbar(
                                  titulo: 'Alerta',
                                  mensaje:
                                      'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
                                  duracion: const Duration(seconds: 4),
                                  icono: const Icon(
                                    Icons.error_outline_outlined,
                                    color: Colors.white,
                                  ));
                            }
                            _.cargando.value = false;
                          },
                        ),
                      ),
                      if (estado) const CircularProgress()
                    ],
                  );
                }),
              )
            ],
          ),
        );
      },
    );
  }
}
