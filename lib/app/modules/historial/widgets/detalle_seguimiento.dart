import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:get/get.dart';

class DetalleSeguimiento extends StatelessWidget {
  const DetalleSeguimiento({
    Key? key,
    required this.pedido,
    required this.formatoHoraFecha,
    required this.estadoPedido1,
    required this.estadoPedido3,
  }) : super(key: key);
  final PedidoModel pedido;
  final Rx<EstadoDelPedido> estadoPedido1;
  final Rx<EstadoDelPedido> estadoPedido3;

  final String Function(Timestamp fecha) formatoHoraFecha;
  @override
  Widget build(BuildContext context) {
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
        subtitle: Text(formatoHoraFecha(pedido.fechaHoraPedido),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.light,
                )),
        content: Container(),
      ),
      Step(
          title: Obx(
            () => Text(
                estadoPedido1.value.idEstado == 'null'
                    ? 'Pedido en espera'
                    : 'Pedido ' +
                        (estadoPedido1.value.nombreEstado!.toLowerCase()),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.black38, fontWeight: FontWeight.w800)),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Obx(() => Text(
                      estadoPedido1.value.idEstado == 'null'
                          ? ''
                          : formatoHoraFecha(
                              estadoPedido1.value.fechaHoraEstado),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppTheme.light,
                          ))),
                ],
              ),
              Row(
                children: [
                  Obx(() => estadoPedido1.value.idEstado == 'null'
                      ? Container()
                      : Text(' Por ' + estadoPedido1.value.nombreUsuario!,
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
            estadoPedido3.value.idEstado == 'null'
                ? 'Pedido  finalizado'
                : 'Pedido ' + (estadoPedido3.value.nombreEstado!.toLowerCase()),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.black38, fontWeight: FontWeight.w800))),
        subtitle:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(children: [
            Obx(() => Text(
                estadoPedido3.value.idEstado == 'null'
                    ? ''
                    : formatoHoraFecha(estadoPedido3.value.fechaHoraEstado),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.light,
                    ))),
          ]),
          Row(
            children: [
              Obx(() => estadoPedido3.value.idEstado == 'null'
                  ? Container()
                  : Text(' Por ' + estadoPedido3.value.nombreUsuario!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.light,
                          ))),
            ],
          )
        ]),
        content: Container(),
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
