import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/global_widgets/modal_alert.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';

class BotonCancelar extends StatelessWidget {
  const BotonCancelar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: kBottomNavigationBarHeight * 1.1,
            margin:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            decoration: BoxDecoration(
              color: AppTheme.blueBackground,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: PrimaryButton(
                texto: "Cancelar",
                onPressed: () =>
                    //modal para confirmar si desea cancelar
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return //Obx
                            (
                                //() =>
                                ModalAlert(
                                    titulo: 'Cancelar pedido',
                                    mensaje:
                                        '¿Está seguro de cancelar su pedido?',
                                    icono: Icons.cancel_outlined,
                                    onPressed: () =>
                                        //en caso de confirmar se actualiza el estado como cancelado
                                        Get.find<ProcesoPedidoController>()
                                            .actualizarEstadoPedido()));
                      },
                    ))));
  }
}
