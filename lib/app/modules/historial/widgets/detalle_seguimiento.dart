import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:get/get.dart';

class DetalleSeguimiento extends StatelessWidget {
  const DetalleSeguimiento({
    Key? key,
    required this.pedido,
  }) : super(key: key);
  final PedidoModel pedido;
  @override
  Widget build(BuildContext context) {
    HistorialController controlador = Get.put(HistorialController());

    //Pedido realizado el cliente (estado1)
    //Pedido aceptado: el cliente puede cancelar o el repartidor puede rechazar(estado5) o aceptar(estado2
    //Pedido finalizado: el cliente puede que haya cancelar o el repartidor puede rechazar(estado5) o aceptar(estado2)

    List<Step> steps = [
      Step(
        title: Text('Pedido realizado',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black38, fontWeight: FontWeight.w800)),
        subtitle: Text(controlador.formatoHoraFecha(pedido.fechaHoraPedido),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.light,
                )),
        content: Container(child: TextSubtitle(text: "data")),
      ),
      Step(
          title: Obx(
            () => Text(
                controlador.estadoPedido1.value?.idEstado == 'null'
                    ? 'Pedido aceptado'
                    : 'Pedido ' +
                        (controlador.estadoPedido1.value!.nombreEstado!
                            .toLowerCase()),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black38, fontWeight: FontWeight.w800)),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Obx(() => Text(
                      controlador.estadoPedido1.value?.idEstado == 'null'
                          ? ''
                          : controlador.formatoHoraFecha(
                              controlador.estadoPedido1.value!.fechaHoraEstado),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppTheme.light,
                          ))),
                ],
              ),
              Row(
                children: [
                  Obx(() => controlador.estadoPedido1.value?.idEstado == 'null'
                      ? Container()
                      : Text(
                          ' Por ' +
                              controlador.estadoPedido1.value!.nombreUsuario!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.light,
                                  ))),
                ],
              )
            ],
          ),
          content: Container()
          /*Obx(() => controlador.estadoPedido1.value?.idEstado == 'null'
            ? Container()
            : Text('Por ' + controlador.estadoPedido1.value!.nombreUsuario!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.light,
                    ))),*/
          ),
      Step(
        title: Obx(() => Text(
            controlador.estadoPedido3.value?.idEstado == 'null'
                ? 'Pedido  finalizado'
                : 'Pedido ' +
                    (controlador.estadoPedido3.value!.nombreEstado!
                        .toLowerCase()),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.black38, fontWeight: FontWeight.w800))),
        subtitle: Obx(() => Text(
            controlador.estadoPedido3.value?.idEstado == 'null'
                ? ''
                : controlador.formatoHoraFecha(
                    controlador.estadoPedido3.value!.fechaHoraEstado),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.light,
                ))),
        content: Obx(() => controlador.estadoPedido3.value?.idEstado == 'null'
            ? Container()
            : Text('Por ' + controlador.estadoPedido3.value!.nombreUsuario!,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.light,
                    ))),
      ),
    ];
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
        onSurface: Colors.black38,
        onPrimary: AppTheme.blueDark,
      )),
      child: Stepper(
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          return Row(
            children: [Container()],
          );
        },
        currentStep: 1,
        steps: steps,
        type: StepperType.vertical,
      ),
    );
  }
}
