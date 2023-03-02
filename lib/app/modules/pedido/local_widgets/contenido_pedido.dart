import 'package:cloud_firestore/cloud_firestore.dart';
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

    return Container(
      margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)
          /*BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))*/
          ),
      alignment: Alignment.centerLeft,
      height: Responsive.getScreenSize(context).height * .09,
      width: Responsive.getScreenSize(context).width * .95,
      child: GetBuilder<ProcesoPedidoController>(
          builder: (_) => GestureDetector(
                onTap: () => _.cargarDetalle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      //  crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder(
                            stream: _.getNotificacion(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const TextDescription(
                                    text: 'Pedido realizado.');
                              }
                              if (snapshot.hasData == true) {
                                try {
                                  var titulo = snapshot.data?.docs.first
                                      .get('tituloNotificacion');
                                  var texto = snapshot.data?.docs.first
                                      .get('textoNotificacion');
                                  Timestamp fecha = snapshot.data?.docs.first
                                      .get('fechaNotificacion');

                                  var fechaProgramada =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          fecha.seconds * 1000);

                                  //
                                  _.showNotificacion(
                                      context,
                                      0,
                                      titulo,
                                      texto,
                                      Timestamp.now().toDate(),
                                      fechaProgramada);

                                  return TextSubtitle(text: titulo);
                                } catch (e) {
                                  Exception(
                                      'Ha ocurrideo un error inesperado...');
                                }
                              }
                         

                              return const TextSubtitle(
                                  text: 'Pedido realizado');
                            }),

                        TextDescription(
                            text: (_.pedido.value.cantidadPedido > 1
                                ? '${_.pedido.value.cantidadPedido} cilindros'
                                : '${_.pedido.value.cantidadPedido} cilindro')),
                        //   const TextDescription(text: "5 min")
                      ],
                    ),
                    Column(
                      children: [
                        Obx(() => TextDescription(
                            text: '\$${_.pedido.value.totalPedido}'))
                      ],
                    )
                  ],
                ),
              )),
    );
  }
}
