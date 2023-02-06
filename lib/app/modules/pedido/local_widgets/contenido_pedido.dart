import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class ContenidoPedido extends StatelessWidget {
  const ContenidoPedido({Key? key, required this.pedido}) : super(key: key);
  final PedidoModel? pedido;

  @override
  Widget build(BuildContext context) {
    /*   final ProcesoPedidoController controladorDePedidos =
        Get.put(ProcesoPedidoController());*/

    return Container(
     
      margin: const EdgeInsets.only(top: 5.0, left: 5, right: 5, bottom: 0),
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      //  shape: Border.all(color: AppTheme.light, width: 0.5),
      child: GestureDetector(
          onTap: () async {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: Responsive.getScreenSize(context).height * .05,
              width: Responsive.getScreenSize(context).width   * .80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const TextSubtitle(text: 'Pedido realizado '),
                      TextDescription(
                          text: (pedido?.totalPedido == null
                                  ? ' '
                                  : '\$${pedido?.totalPedido} de ') +
                              (pedido?.cantidadPedido == null
                                  ? ''
                                  : pedido!.cantidadPedido > 1
                                      ? '${pedido?.cantidadPedido} cilindros'
                                      : '${pedido?.cantidadPedido} cilindro')),
                      //   const TextDescription(text: "5 min")
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
