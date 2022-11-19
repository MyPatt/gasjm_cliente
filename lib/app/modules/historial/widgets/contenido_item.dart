import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/historial_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/modules/historial/widgets/contenido_informacion.dart';
import 'package:gasjm/app/modules/historial/widgets/contenido_linea.dart';

class ContenidoItem extends StatelessWidget {
   const ContenidoItem({
    Key? key, required this.index, required this.date, required this.transaction,
  }) : super(key: key);
  final int index;
  final DateTime date;
  final PedidoModel transaction;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(width: 20),
          const ContenidoLinea(),
          Expanded(
            flex: 1,
            child: ContenidoInformacion(transaction),
          ),
        ],
      ),
    );
  }
}
