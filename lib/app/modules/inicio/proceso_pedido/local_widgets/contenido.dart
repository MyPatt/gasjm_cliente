import 'package:flutter/cupertino.dart';
import 'package:gasjm/app/modules/inicio/proceso_pedido/local_widgets/mapa.dart';
import 'package:gasjm/app/modules/inicio/proceso_pedido/local_widgets/notificacion_estado.dart';

class ContenidoProcesoPedido extends StatelessWidget {
  const ContenidoProcesoPedido({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[NotificacionEstado(), MapaWidget()],
    );
  }
}
