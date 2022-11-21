import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:get/get.dart';

class DettalleSeguimiento extends StatelessWidget {
  const DettalleSeguimiento({
    Key? key,
    required this.pedido,
  }) : super(key: key);
  final PedidoModel pedido;
  @override
  Widget build(BuildContext context) {
    HistorialController controladorDePedidos = Get.put(HistorialController());
    List<Step> steps = [
      Step(
        title: Text(
          'Pedido realizado',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppTheme.blueDark, fontWeight: FontWeight.w500),
        ),

        subtitle: Text(
          controladorDePedidos.formatoHoraFecha(pedido.fechaHoraPedido),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.light,
                fontWeight: FontWeight.w500,
              ),
        ),
        // isActive: controladorDePedidos.activeStep1.value,
        content: Container(),
      ),
      Step(
        title: Text(
          'Pedido aceptado',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppTheme.light, fontWeight: FontWeight.w500),
        ),

        subtitle: Text(
          controladorDePedidos.formatoHoraFecha(
              pedido.estadoPedido1?.fechaHoraEstado ?? Timestamp.now()),
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.light,
                fontWeight: FontWeight.w500,
              ),
        ),
        content: Container(),
        //isActive: controladorDePedidos.activeStep2.value,
      ),
      Step(
        title: Text('Pedido en camino',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.light,
                )),
        content: Container(),
        isActive: false,
      ),
      Step(
        title: Text('Pedido finalizado',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppTheme.light,
                )),
        content: Container(),
        state: StepState.complete,
        isActive: false,
      ),
    ];
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
        primary: Colors.grey,

        //onSurface: AppTheme.blueDark,
      )),
      child: Stepper(
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          return Row(
            children: [Container()],
          );
        },
        //currentStep: controladorDePedidos.currentStep.value,
        currentStep: 0,
        steps: steps,
        type: StepperType.vertical,
      ),
    );
  }
}
