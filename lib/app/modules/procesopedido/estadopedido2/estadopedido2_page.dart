import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/local_widgets/boton_cancelar.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/local_widgets/contenido_mapa.dart';
import 'package:gasjm/app/modules/procesopedido/estadopedido2/estadopedido2_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

//Pantalla   del cliente cuando su pedido se encuentra procesando
class EstadoPedido2Page extends StatelessWidget {
  const EstadoPedido2Page({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    MapTileLayerController controller = MapTileLayerController();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 226, 227, 1),
      //Menú deslizable a la izquierda con opciones del  usuario
      drawer: const MenuLateral(),
      //Barra de herramientas de opciones para  agenda y  historial
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: AppTheme.blueBackground,
        actions: [
          ElevatedButton(
            child: Text('Add'),
            onPressed: () {
              controller.insertMarker(0);
              print(controller.markersCount);
            },
          ),
        ],
        title: const Text('Gas J&M'),
      ),
      body: GetBuilder<EstadoPedido2Controller>(
          builder: (_) => StreamBuilder<QuerySnapshot>(
              stream: _.getUbicacionesDeRepartidores(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
                if (snapchat.hasData) {
                  List<Model> _data = [];
                  //
                  _data.add(Model(
                      _.posicionDestinoPedidoCliente.value.latitude,
                      _.posicionDestinoPedidoCliente.value.longitude,
                      //Image.asset('assets/icons/marcadorCliente.png'
                      Icon(Icons.abc)));
//
                  controller.insertMarker(0);

                  var i = 0;

                  for (var repartidor in snapchat.data!.docs) {
                    i++;
                    Direccion ubicacionActualRepartidor =
                        Direccion.fromMap(repartidor.get("ubicacionActual"));

                    _data.add(Model(ubicacionActualRepartidor.latitud,
                        ubicacionActualRepartidor.longitud, Icon(Icons.abc)
                        //Image.asset('assets/icons/camiongasjm.png'
                        ));

                    controller.insertMarker(i);
                  }

                  print('@@@@@@@${_data.length}');
                  controller.notifyListeners();

                  //
                  return SfMaps(layers: [
                    MapTileLayer(
                      initialFocalLatLng: MapLatLng(
                          _.pedido.value.direccion.latitud,
                          _.pedido.value.direccion.longitud),
                      initialZoomLevel: 10,
                      initialMarkersCount: _data.length,
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      markerBuilder: (BuildContext context, int index) {
                        return MapMarker(
                          /*  latitude: _data[index].latitude,
                          longitude: _data[index].longitude,
                          child: _data[index].icon,*/
                          latitude: _.pedido.value.direccion.latitud,
                          longitude: _.pedido.value.direccion.longitud,
                          child:
                              Image.asset('assets/icons/marcadorCliente.png'),
                          size: const Size(40, 40),
                        );
                      },
                      controller: controller,
                    )
                  ]);
                }
                return const Center(child: CircularProgress());
              })),
    );
  }
}
