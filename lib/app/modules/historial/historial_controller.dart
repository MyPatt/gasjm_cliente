import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistorialController extends GetxController {
  final _pedidosRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

//
  final cargandoPedidos = true.obs;

  //Pedidos realizado

  final RxList<PedidoModel> _listaPedidosRealizados = <PedidoModel>[].obs;
  RxList<PedidoModel> get listaPedidosRealizados => _listaPedidosRealizados;

  //Obtener fecha de los pedidos
  final RxList<Timestamp> _listaFechas = <Timestamp>[].obs;
  RxList<Timestamp> get listaFechas => _listaFechas;
//
//Visible informacion del detalle de=historial
  RxBool visibleDetalle = false.obs;
  final int indice = 0;
  //
  @override
  void onInit() {
    super.onInit();
    cargarListaPedidosRealizadosPorCliente();
  }

  //Metodo para cargarLista de los pedidos para el administrador
  Future<void> cargarListaPedidosRealizadosPorCliente() async {
    try {
      cargandoPedidos.value = true;
      //Obtener cedula del usuario actual
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String cedulaCliente = prefs.getString("cedula_usuario") ?? '';
      //Guardar en una var auxilar la lista
      var lista = await _pedidosRepository.getListaPedidosPorField(
              field: "idCliente", dato: cedulaCliente) ??
          [];
//

      //Obtener datos del usuario y guardar
      for (var i = 0; i < lista.length; i++) {
        final nombre = await _getNombresCliente(lista[i].idCliente);
        final direccion = await _getDireccionXLatLng(
            LatLng(lista[i].direccion.latitud, lista[i].direccion.longitud));
        final estado = await _getNombreEstado(lista[i].idEstadoPedido);

        lista[i].nombreUsuario = nombre;
        lista[i].direccionUsuario = direccion;
        lista[i].estadoPedidoUsuario = estado;
        //
      }
      //
      var listFechasAux = lista.map((e) => e.fechaHoraPedido).toList();
//

      _listaFechas.value = listFechasAux;

      //La lista auxilaiar asignale a la lista observable
      _listaPedidosRealizados.value = lista;

      print(_listaFechas.length);
      print("++++++++++++++++++++++++=");
      print(listFechasAux);
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargandoPedidos.value = false;
  }

  //
  Future<String> _getNombresCliente(String cedula) async {
    final nombre =
        await _personaRepository.getNombresPersonaPorCedula(cedula: cedula);
    return nombre ?? 'Usuario';
  }

  Future<String> _getDireccionXLatLng(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
    Placemark lugar = placemark[0];

//
    return _getDireccion(lugar);
  }

  String _getDireccion(Placemark lugar) {
    //
    if (lugar.subLocality?.isEmpty == true) {
      return lugar.street.toString();
    } else {
      return '${lugar.street}, ${lugar.subLocality}';
    }
  }

  //Metodo para encontrar el  nombre del estado
  Future<String> _getNombreEstado(String idEstado) async {
    final nombre =
        await _pedidosRepository.getNombreEstadoPedidoPorId(idEstado: idEstado);
    return nombre ?? 'Pedido';
  }

//
  String formatoHora(Timestamp fecha) {
    String formatoFecha = DateFormat.yMd("es").format(fecha.toDate());
    String formatoHora = DateFormat.Hm("es").format(fecha.toDate());
    return "$formatoHora $formatoFecha";
  }

//
  String formatoHoraFecha(Timestamp fecha) {
    String formatoFecha = DateFormat.yMd("es").format(fecha.toDate());
    String formatoHora = DateFormat.Hm("es").format(fecha.toDate());
    return "$formatoHora $formatoFecha";
  }
}
