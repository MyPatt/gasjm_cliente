import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/proceso_pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';

class ContenidoPedido extends StatelessWidget {
  const ContenidoPedido({Key? key, required this.pedido}) : super(key: key);
  final PedidoModel? pedido;

  @override
  Widget build(BuildContext context) {
 /*   final ProcesoPedidoController controladorDePedidos =
        Get.put(ProcesoPedidoController());*/

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 5.0, left: 5, right: 5, bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      //  shape: Border.all(color: AppTheme.light, width: 0.5),
      child: GestureDetector(
          onTap: () async {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    TextSubtitle(text: 'Pedido realizado'),
                    /*  TextSubtitle(
                      text: controladorDePedidos.formatoFecha(
                          pedido?.fechaHoraPedido ?? Timestamp.now()),
                    )*/
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextDescription(
                        text: pedido?.cantidadPedido == null
                            ? ''
                            : pedido!.cantidadPedido > 1
                                ? '${pedido?.cantidadPedido} cilindros'
                                : '${pedido?.cantidadPedido} cilindro'),
                    //   const TextDescription(text: "5 min")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextDescription(
                        text: pedido?.totalPedido == null
                            ? ''
                            : '\$ ${pedido?.totalPedido}'),
                    /*
                     TextDescription(text: '300 m'),
                   */
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
