import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/modules/historial/widgets/detalle_informacion.dart';
import 'package:gasjm/app/modules/historial/widgets/detalle_seguimiento.dart';
import 'package:get/get.dart';

class DetalleHistorial extends StatelessWidget {
  const DetalleHistorial(
      {Key? key,
      required this.pedido,
      required this.cargandoDetalle,
      required this.estadoPedido1,
      required this.estadoPedido3,
      required this.formatoHoraFecha})
      : super(key: key);
  final PedidoModel pedido;
  final RxBool cargandoDetalle;
  final Rx<EstadoDelPedido> estadoPedido1;
  final Rx<EstadoDelPedido> estadoPedido3;

  final String Function(Timestamp fecha) formatoHoraFecha;
  @override
  Widget build(BuildContext context) {
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
          child: Container(
            height: Responsive.hp(context) * 0.82,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: ListView(
                /*    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,*/
                children: <Widget>[
                  /*  const CircleAvatar(
                      backgroundColor: AppTheme.light,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.route_outlined,
                          color: AppTheme.blueDark,
                          size: 50,
                        ),
                        radius: 55.0,
                      ),
                      radius: 56.0,
                    ),
                    SizedBox(
                        height: Responsive.getScreenSize(context).height * .05),*/
                  DetalleInformacion(pedido: pedido),
                  Obx(() => !cargandoDetalle.value
                      ? DetalleSeguimiento(
                          pedido: pedido,
                          formatoHoraFecha: formatoHoraFecha,
                          estadoPedido1: estadoPedido1,
                          estadoPedido3: estadoPedido3,
                        )
                      : const Expanded(
                          child: Center(child: CircularProgress())))
                ]),
          ),
        ),
      ),
    );
  }
}
