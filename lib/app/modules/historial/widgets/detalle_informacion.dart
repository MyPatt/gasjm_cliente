import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';

class DetalleInformacion extends StatelessWidget {
  const DetalleInformacion({Key? key, required this.pedido}) : super(key: key);
  final PedidoModel pedido;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextSubtitle(
            text: pedido.cantidadPedido > 1
                ? '${pedido.cantidadPedido} cilindros'
                : '${pedido.cantidadPedido} cilindro',
            color: AppTheme.light,
          ),
          Text(
            "\$ ${pedido.totalPedido.toStringAsFixed(2)}",
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.light,
                  fontWeight: FontWeight.w400,
                ),
          ),
          const SizedBox(height: 10.0),
          Text(
            pedido.nombreUsuario ?? 'Cliente',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppTheme.blueDark, fontWeight: FontWeight.w800),
          ),
          /*    Row(
            children: <Widget>[
              const Icon(
                Icons.credit_card_outlined,
                size: 15.0,
              ),
              const SizedBox(width: 10.0),
              Text(
                pedido.idCliente,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.blueDark,
                    ),
              ),
            ],
          ),*/
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.room_outlined,
                color: AppTheme.light,
                size: 18.0,
              ),
              const SizedBox(width: 10.0),
              Text(
                pedido.direccionUsuario ?? 'Sin ubicación',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.light,
                    ),
              ),
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
        ]);
  }
}
