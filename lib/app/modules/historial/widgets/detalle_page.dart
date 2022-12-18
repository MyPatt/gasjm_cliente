import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:gasjm/app/modules/historial/widgets/detalle_informacion.dart';
import 'package:gasjm/app/modules/historial/widgets/detalle_seguimiento.dart';
import 'package:get/get.dart';

class DetalleHistorial extends StatelessWidget {
  const DetalleHistorial({Key? key, required this.pedido, required this.cargandoDetalle}) : super(key: key);
  final PedidoModel pedido;
  final RxBool cargandoDetalle;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const CircleAvatar(
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
                        height: Responsive.getScreenSize(context).height * .05),
                    DetalleInformacion(pedido: pedido),
                    Obx(() => !cargandoDetalle.value
                        ? DetalleSeguimiento(pedido: pedido)
                        : const Expanded(
                            child: Center(child: CircularProgress())))
                  ]),
            ),
          ),
        ),
    
    );
  }
}
