import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/historial_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/modules/historial/widgets/contenido_informacion.dart';
import 'package:gasjm/app/modules/historial/widgets/contenido_linea.dart';
import 'package:intl/intl.dart';

class ContenidoItem extends StatelessWidget {
  const ContenidoItem({
    Key? key,
    required this.index,
    required this.date,
    required this.transaction, required this.context,
  }) : super(key: key);
  final int index;
  final BuildContext context;
  final DateTime date;
  final PedidoModel transaction;
  @override
  Widget build( context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(width: 20),
          ContenidoLinea(index, context,),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // color: Theme.of(context).accentColor,
            child: Text(
              DateFormat("hh:mm a").format(date),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppTheme.light,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ContenidoInformacion(transaction,context),
          ),
        ],
      ),
    );
  }
}
