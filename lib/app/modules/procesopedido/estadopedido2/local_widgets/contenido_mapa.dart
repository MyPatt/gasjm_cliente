import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/estadopedido2_controller.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/local_widgets/contenido_pedido.dart';
import 'package:get/get.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

class ContenidoMapa extends StatelessWidget {
  ContenidoMapa({
    Key? key,
  }) : super(key: key);
//sk.eyJ1IjoibWFzYXoiLCJhIjoiY2xmMzFjaTNyMG53aTNzbGNvaG5kbmEybyJ9.fSg2DP3Er0XT7ICuPNQk0A
  final _ = Get.put(EstadoPedido2Controller());
  @override
  Widget build(BuildContext context) {
    //return Column(    children: const <Widget>[NotificacionEstado(), MapaWidget()],   );
    return Column(
      children: [
        const ContenidoPedido(),
        Expanded(
            child: MapboxMap(
              onMapCreated: _.onMapCreated,
          accessToken:
              'pk.eyJ1IjoibWFzYXoiLCJhIjoiY2xleTJsNW4zMGZ2NjQybzBxNjlpZmV5ZyJ9.N6R32DyDwNP82pRSbUL7sg',
          initialCameraPosition: CameraPosition(
              target: LatLng(
                // -1.284229, -78.663387
                _.posicionDestinoPedidoCliente.value.latitude,
                _.posicionDestinoPedidoCliente.value.longitude,
              ),
              zoom: 14),
          //myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          minMaxZoomPreference: const MinMaxZoomPreference(13, 16),
          //onMapCreated: _.onMapCreated,onStyleLoadedCallback: _.onStyleLoadedCallback(),
        )
            /* FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 13,
              center: LatLng(
                // -1.284229, -78.663387
                _.posicionDestinoPedidoCliente.value.latitude,
                _.posicionDestinoPedidoCliente.value.longitude,
              ),
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/masaz/clf479xgt000v01orudloehbf/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFzYXoiLCJhIjoiY2xleTJsNW4zMGZ2NjQybzBxNjlpZmV5ZyJ9.N6R32DyDwNP82pRSbUL7sg",
                    additionalOptions: {
                       'mapStyleId': 'clf479xgt000v01orudloehbf',
                     'accessToken':   'pk.eyJ1IjoibWFzYXoiLCJhIjoiY2xleTJsNW4zMGZ2NjQybzBxNjlpZmV5ZyJ9.N6R32DyDwNP82pRSbUL7sg'
                    }
                /*  additionalOptions: {
                  'mapStyleId': AppConstants.mapBoxStyleId,
                  'accessToken': AppConstants.mapBoxAccessToken,
                },*/
              ),
            ],
          ),*/
            )
      ],
    );
  }
}
