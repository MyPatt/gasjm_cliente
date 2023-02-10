import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/pedido/proceso_pedido_controller.dart';
import 'package:get/get.dart';

class ContenidoPedido extends StatelessWidget {
  const ContenidoPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*   final ProcesoPedidoController controladorDePedidos =
        Get.put(ProcesoPedidoController());*/

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.centerLeft,
          height: Responsive.getScreenSize(context).height * .05,
          width: Responsive.getScreenSize(context).width * .95,
          child: GetBuilder<ProcesoPedidoController>(
              builder: (_) => Row(
                    children: [
                      Column(
                        children: <Widget>[
                          const TextSubtitle(text: 'Pedido realizado '),
                          TextDescription(
                              text: ('\$${_.pedido.value.totalPedido} de ') +
                                  (_.pedido.value.cantidadPedido > 1
                                      ? '${_.pedido.value.cantidadPedido} cilindros'
                                      : '${_.pedido.value.cantidadPedido} cilindro')),
                          //   const TextDescription(text: "5 min")
                        ],
                      ),
                      Column(
                        children: [
                          Obx(() => TextDescription(text: '${_.distanciaRuta}  m'))
                        ],
                      )
                    ],
                  )),
        ));
  }
}
