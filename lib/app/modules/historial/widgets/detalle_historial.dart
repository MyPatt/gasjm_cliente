import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:get/get.dart';

class DetalleHistorial extends StatelessWidget {
  const DetalleHistorial({Key? key, required this.pedido}) : super(key: key);
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: AppTheme.blueBackground,
        title: const Text(
          "Detalle del pedido",
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: Responsive.hp(context) * 0.9,
              child: ListView(children: [
                ///
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pedido.nombreUsuario ?? 'Cliente',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: AppTheme.blueDark,
                                      fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.credit_card_outlined,
                                  size: 15.0,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  pedido.idCliente,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppTheme.blueDark,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.room_outlined,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  pedido.direccionUsuario ?? 'Sin ubicación',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        color: AppTheme.blueDark,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppTheme.blueBackground,
                                radius: 20.0,
                                child: TextSubtitle(
                                  text: pedido.cantidadPedido.toString(),
                                  color: Colors.white,
                                )
                                /*  child: Icon(
                              Icons.person_outline_outlined,
                              size: 23.0,
                            ),*/
                                ),
                            Text(
                              "\$ ${pedido.totalPedido.toStringAsFixed(2)}",
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppTheme.blueDark,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      //"Barrio Santa Rosa a una cuadra del parque, puerta negra.",
                      pedido.notaPedido ?? "",
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.light,
                          ),
                    ),

                    const SizedBox(height: 10.0),

                    Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                        primary: Colors.grey,

                        //onSurface: AppTheme.blueDark,
                      )),
                      child: Stepper(
                        controlsBuilder:
                            (BuildContext ctx, ControlsDetails dtl) {
                          return Row(
                            children: [Container()],
                          );
                        },
                        //currentStep: controladorDePedidos.currentStep.value,
                        currentStep: 0,
                        steps: steps,
                        type: StepperType.vertical,
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    ///  PedidosEnEsperaPage(idPedido: e.idPedido)
                  ]),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
