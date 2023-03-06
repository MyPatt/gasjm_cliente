import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/estadopedido2_controller.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/local_widgets/contenido_pedido.dart'; 
import 'package:get/get.dart'; 
import 'package:syncfusion_flutter_maps/maps.dart';

class ContenidoMapa extends StatelessWidget {
  ContenidoMapa({
    Key? key,
  }) : super(key: key);

  final _ = Get.put(EstadoPedido2Controller());
  @override
  Widget build(BuildContext context) {
    //return Column(    children: const <Widget>[NotificacionEstado(), MapaWidget()],   );
    return Column(
      children: [
        const ContenidoPedido(),
        Expanded(
            child:SfMaps(
      layers: [
        MapShapeLayer(
          source: _.dataSource,
          sublayers: [
            MapPolylineLayer(
              polylines: List<MapPolyline>.generate(
               _. polylines.length,
                (int index) {
                  return MapPolyline(
                    points: _.polylines[index],
                  );
                },
              ).toSet(),
            ),
          ],
          zoomPanBehavior: _.zoomPanBehavior,
        ),
      ],
    ),
   )
      ],
    );
  }
}
