import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcesoPedidoController extends GetxController {
  final pedidoRepository = Get.find<PedidoRepository>();
  //Variable para dsatos del pedido
  RxString? descripcionEstadoPedido;
  final Rx<PedidoModel> pedido = PedidoModel(
          idProducto: "",
          idCliente: "",
          idRepartidor: "",
          direccion: Direccion(latitud: 0, longitud: 0),
          idEstadoPedido: "",
          fechaHoraPedido: Timestamp.now(),
          diaEntregaPedido: "",
          cantidadPedido: 0,
          notaPedido: "",
          totalPedido: 0)
      .obs;
  //Variable para mostrar el avance de la consulta desde firestore
  final cargandoPedidos = true.obs;

  //Variables para el mapa
  GoogleMapController? _mapaController;

  final Rx<LatLng> _posicionCliente = const LatLng(-0.2053476, -79.4894387).obs;

  Rx<LatLng> get posicionCliente => _posicionCliente.value.obs;

  final Map<MarkerId, Marker> _marcadores = {};
  Set<Marker> get marcadores => _marcadores.values.toSet();

  late String id = 'MakerIdCliente';
  @override
  void onInit() {
    super.onInit();

    //Obtener  datos del pedido  realizado
    _cargarDatosDelPedidoRealizado();
  }

//Metodo para cancelar el pedido
  Future<void> cancelarPedido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("pedido_esperando", false);
    //
    Get.offAllNamed(AppRoutes.inicio);
  }

  //Metodo que devuelve una fecha tipo timestap en formato d/m/y  h:m
  String formatoFecha(Timestamp fecha) {
    String formatoFecha = DateFormat.yMd("es").format(fecha.toDate());
    String formatoHora = DateFormat.Hm("es").format(fecha.toDate());
    return "$formatoFecha $formatoHora";
  }

  //Metodo que obtiene el ultimo pedido realizado y aun no se a finalizado
  Future<void> _cargarDatosDelPedidoRealizado() async {
    try {
      cargandoPedidos.value = true;

      //CARGAR DATOS DEL PEDIDO
      pedido.value = await _getDatosPedido();
      //

      //Datos de la posicion del cliente

      _posicionCliente.value = LatLng(
          pedido.value.direccion.latitud, pedido.value.direccion.longitud);

      //Mostrar el marcador del cliente en el mapa

      _agregarMarcadorCliente(_posicionCliente.value);
    } on FirebaseException catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde. ${e.message}',
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }

    cargandoPedidos.value = false;
  }

  //Diseno mapa
  void onMapaCreado(GoogleMapController controller) {
    _mapaController = controller;
    controller.setMapStyle(estiloMapa);
  }

  //

  Future<void> _agregarMarcadorCliente(LatLng posicion) async {
    final markerId = MarkerId(id);

    BitmapDescriptor _marcadorCliente = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/marcadorCliente.png",
    );

    final marker = Marker(
      markerId: markerId,
      position: posicion,
      draggable: true,
      icon: _marcadorCliente,
    );

    _marcadores[markerId] = marker;
  }

  Future<PedidoModel> _getDatosPedido() async {
    //Obtener cedula de  usuario actual
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cedula = prefs.getString("cedula_usuario") ?? '';
    //Buscar el ultima pedido realizado
    var pedido = await pedidoRepository.getPedidoPorField(
        field: "idCliente", dato: cedula);
    return pedido!;
  }
}
