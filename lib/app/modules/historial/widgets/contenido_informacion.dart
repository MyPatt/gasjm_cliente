import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContenidoInformacion extends StatelessWidget {
  const ContenidoInformacion(this.pedido,this.context, {Key? key}) : super(key: key);
  final PedidoModel pedido;
  final BuildContext context;
  @override
  Widget build( context) {
    final HistorialController controlador = Get.put(HistorialController());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      //  shape: Border.all(color: AppTheme.light, width: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {},
                /*=> Get.to(DetallePedido(
                    e: e, indiceCategoriaPedido: indiceCategoriaPedido)),*/
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextSubtitle(
                          text: '${pedido.direccionUsuario}',
                          // style: TextoTheme.subtitleStyle2,
                        ),
                        TextSubtitle(
                          text: '${pedido.cantidadPedido}',
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                            text: controlador
                                .formatoHoraFecha(pedido.fechaHoraPedido)),
                        const TextDescription(text: '5 min')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                            //text: controladorDePedidos  .formatoFecha(e.fechaHoraPedido)
                            text: DateFormat("es")
                                .format(pedido.fechaHoraPedido.toDate())),
                        const TextDescription(text: '300 m')
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
