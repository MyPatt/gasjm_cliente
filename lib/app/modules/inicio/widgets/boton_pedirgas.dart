import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/inicio/inicio_controller.dart';
import 'package:gasjm/app/modules/inicio/widgets/form_pedirgas.dart';
import 'package:get/get.dart';

//Boton en la parte inferior del mapa para mostrar el form para pedir el gas
class BotonPedirGas extends StatelessWidget {
  const BotonPedirGas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InicioController>(
        builder: (_) => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: kBottomNavigationBarHeight * 1.1,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  decoration: BoxDecoration(
                    color: AppTheme.blueBackground,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  //Esperando que se obtenga la ubicacion actual
                  child: Obx(
                    () => _.direccion.value == 'Buscando dirección...'
                        ? const Text('')
                        : PrimaryButton(
                            texto: "Pedir el gas",
                            onPressed: () async {
                              _.actualizarDatosDelForm();
                              //La hora actual esta en rango de atencion se realiza el pedido caso contrario se agenda
                              if (!(_.horarioActual.seconds >=
                                      _.horarioApertura.seconds &&
                                  _.horarioActual.seconds <=
                                      _.horarioCierre.seconds)) {
                                //
                                _.diaDeEntregaPedidoController.value.text =
                                    "Mañana";
                                // 
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return Obx(
                                      () => ModalAlert(
                                          titulo: 'Agendar pedido',
                                          mensaje:
                                              'Fuera del horario de atención ${_.cadenaHorarioAtencion.value}. ¿Desea agendar el pedido?',
                                          icono: Icons.edit_calendar_outlined,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) =>
                                                    (const FormPedirGas()));
                                          }),
                                    );
                                  },
                                );
                              } else {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) =>
                                        (const FormPedirGas()));
                              }
                            }),
                  )),
            ));
  }
}
