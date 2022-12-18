import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/notificacion_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/repository/notificacion_repository.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/modules/historial/widgets/detalle_page.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcesoPedidoController extends GetxController {
  final _pedidoRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();
  final _notificacionRepository = Get.find<NotificacionRepository>();
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

//
  final RxList<String> _notificaciones = ["Sin notificaciones, , "].obs;
  RxList<String> get notificaciones => _notificaciones;

  Rx<LatLng> get posicionCliente => _posicionCliente.value.obs;

  final Map<MarkerId, Marker> _marcadores = {};
  Set<Marker> get marcadores => _marcadores.values.toSet();

  late String id = 'MakerIdCliente';
  @override
  void onInit() {
    super.onInit();
    //Obtener  datos del pedido  realizado
    _cargarDatosDelPedidoRealizado();

    //
  }

  @override
  void onReady() {
    super.onReady();
    
  }

//Metodo para cancelar el pedido
  Future<void> _pedidoCancelado() async {
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

      //
    cargarListaNotificaciones();
      
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
    //Obtener uid de  usuario actual
    final _personaRepository = Get.find<PersonaRepository>();
    String _idCliente = _personaRepository.idUsuarioActual;

    //Buscar el ultima pedido realizado
    var pedido = await _pedidoRepository.getPedidoPorField(
        field: "idCliente", dato: _idCliente);

    return pedido!;
  }

  //Metodo para actualizar el estado de un pedido
  Future<void> actualizarEstadoPedido(String idPedido) async {
    ///en estadoPedido3 se guarda info   de si se cancela o finaliza el pedidoaceptado
    try {
      await _pedidoRepository.updateEstadoPedido(
          idPedido: idPedido,
          estadoPedido: "estado4",
          numeroEstadoPedido: "estadoPedido3");
      //
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: 'Su pedido fue cancelado!',
          icono: const Icon(
            Icons.info_outlined,
            color: Colors.white,
          ));
      //
      await _pedidoCancelado();
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
  }

  Future<void> cargarListaNotificaciones() async {
    try {
      print("***************************${pedido.value.idPedido}");

      //CARGAR DATOS DEL PEDIDO
      List<Notificacion>? aux =
          await _notificacionRepository.getNotificacionesPorField(
              field: "idPedidoNotificacion", dato: pedido.value.idPedido!);
      _notificaciones.clear();

      print(aux?.length.toInt());
      if (aux!.length.toInt() > 0) {
        for (var element in aux) {
          _notificaciones.add("${element.tituloNotificacion}, por ${element.textoNotificacion},${formatoHoraFecha(element.fechaNotificacion)}");
        }

        print("${aux[0].textoNotificacion} ......................");
      }

      //
      print("***************************${notificaciones.length}");
      //Datos de la posicion del cliente

    } catch (e) {
      //
    }
  }

//
  RxBool cargandoDetalle = false.obs;
  final Rx<EstadoDelPedido?> _estadoPedido1 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  final Rx<EstadoDelPedido?> _estadoPedido3 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  Rx<EstadoDelPedido?> get estadoPedido1 => _estadoPedido1;
  Rx<EstadoDelPedido?> get estadoPedido3 => _estadoPedido3;

  //El estadoPedido2 se usa por el repartidor
  Future<void> cargarDetalle(String idPedido) async {
    PedidoModel? pedido = await _pedidoRepository.getPedidoPorField(
        field: "idPedido", dato: idPedido);

    _cargarPaginaDetalle(pedido!);
    //Limpiar datos
    _estadoPedido1.value = EstadoDelPedido(
        idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "");
    _estadoPedido3.value = EstadoDelPedido(
        idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "");
//
    try {
      cargandoDetalle.value = true;
      //
      var aux1 = await _pedidoRepository.getEstadoPedidoPorField(
          uid: pedido.idPedido!, field: "estadoPedido1");
      var aux3 = await _pedidoRepository.getEstadoPedidoPorField(
          uid: pedido.idPedido!, field: "estadoPedido3");

      if (aux1 != null) {
        aux1.nombreEstado = await _getNombreEstado(aux1.idEstado);
        aux1.nombreUsuario = await _personaRepository.getNombresPersonaPorUid(
            uid: aux1.idPersona);
        _estadoPedido1.value = aux1;
      }

      if (aux3 != null) {
        aux3.nombreEstado = await _getNombreEstado(aux3.idEstado);
        aux3.nombreUsuario = await _personaRepository.getNombresPersonaPorUid(
            uid: aux3.idPersona);
        _estadoPedido3.value = aux3;
      }

      //

    } catch (e) {
      Exception("Error al cargar detalle del pedido");
    }
    cargandoDetalle.value = false;
  }

//
  void _cargarPaginaDetalle(PedidoModel pedido) {
    Get.to(
        DetalleHistorial(
          pedido: pedido,
          cargandoDetalle: cargandoDetalle,
        ),
        routeName: 'detalle');
  }

  //Metodo para encontrar el  nombre del estado
  Future<String> _getNombreEstado(String idEstado) async {
    final nombre =
        await _pedidoRepository.getNombreEstadoPedidoPorId(idEstado: idEstado);
    return nombre ?? 'Pedido';
  }

 String formatoHoraFecha(Timestamp fecha) {
    String formatoFecha = DateFormat.yMd("es").format(fecha.toDate());
    String formatoHora = DateFormat.Hm("es").format(fecha.toDate());
    return "$formatoHora $formatoFecha";
  }
}
