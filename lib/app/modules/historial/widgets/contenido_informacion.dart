import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:intl/intl.dart';

class ContenidoInformacion extends StatelessWidget {
   const ContenidoInformacion(this.transaction, {Key? key}) : super(key: key);
  final PedidoModel transaction;
  @override
  Widget build(BuildContext context) {
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
                          text: 'e.nombreUsuario ??\'Cliente',
                          // style: TextoTheme.subtitleStyle2,
                        ),
                        TextSubtitle(
                          text: '11',
                          // text: 'e.cantidadPedido.toString()',
                          //  style: TextoTheme.subtitleStyle2
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                            text: 'e.direccionUsuario ?? \'Sin ubicación'),
                        const TextDescription(text: '5 min')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                            //text: controladorDePedidos  .formatoFecha(e.fechaHoraPedido)
                            text: DateFormat("es")
                                .format(transaction.fechaHoraPedido.toDate())),
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
