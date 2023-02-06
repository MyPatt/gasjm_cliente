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
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class ProcesoPedidoController extends GetxController {
  //Repositorios
  final _pedidoRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();
  final _notificacionRepository = Get.find<NotificacionRepository>();

  //Variable para dsatos del pedido
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
  final cargandoDatosDelPedidoRealizado = false.obs;

  //Contralador del mapa
  // ignore: unused_field
  GoogleMapController? controladorGoogleMap;

  //Posicion del destino final para entregar el pedido que es el cliente, inicializado
  final Rx<LatLng> _posicionDestinoCliente =
      const LatLng(-0.2053476, -79.4894387).obs;
  Rx<LatLng> get posicionDestinoPedidoCliente =>
      _posicionDestinoCliente.value.obs;

  //Lista observable que muestra las notificaciones del pedido, inicializado sin notificaciones.
  // En caso de que haya notificaciones se carga los datos
  final RxList<String> _notificaciones =
      ["Sin notificaciones, ,En este momento"].obs;
  RxList<String> get notificaciones => _notificaciones;

  //Lista de marcadores (vehiculo y cliente)
  final Map<MarkerId, Marker> marcadoresAux = {};
  Set<Marker> get marcadores => marcadoresAux.values.toSet();

  //Borrar
  late String id = 'MakerIdCliente';

  //Variable observable que muestra la direccion/ destino para entregar el pedido, esto se visualiza en un modal
  RxString direccion = ''.obs;

  //Varriable que describe en el estado del pedido, esto se visualiza en un modal
  RxString? descripcionEstadoPedido;

  //Variable de rotacion que muestra el sentido en que va el vehiculo repartidor
  final RxDouble rotacionMarcadorVehiculoRepartidor = 0.0.obs;

  //METODOS PROPIOS GETX
  @override
  void onInit() {
    super.onInit();
    //Obtener  datos del pedido  realizado
    Future.wait([_cargarDatosDelPedidoRealizado()]);

    //Obtiene el nombre de direccion del destino del pediod a partir de la posicion en LatLng
    _cargarDireccionDestinoDelPedido();

    //TODO: obtner ubicacion actual del repartidor no del cliente

    //Obtener la ruta del viaje a partir de la ubicacion actual del vehiculo repartidor hasta el destino del pedido
    // cargarPuntosDeLaRutaDelPedido();
    //getUbicacionUsuario();

    //Se asigna los iconos personalizados a los marcadores del mapa (detinopedido y vehiculo)
    cargarIconosMarcadoresDelMapa();
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
      cargandoDatosDelPedidoRealizado.value = true;

      //CARGAR DATOS DEL PEDIDO
      var aux = await _getDatosPedido();
      print(".......................");
      print(aux.direccion.latitud);
      print(aux.direccion.longitud);
      String _nombreCliente = _personaRepository.nombreUsuarioActual;

      var estado = await _getNombreEstado(aux.idEstadoPedido);

      //
      aux.nombreUsuario = _nombreCliente;

      //   aux.direccionUsuario = direccion;
      aux.estadoPedidoUsuario = estado;

      pedido.value = aux;

      //Datos de la posicion del cliente

      _posicionDestinoCliente.value = LatLng(
          pedido.value.direccion.latitud, pedido.value.direccion.longitud);

      direccion.value = await _getDireccionXLatLng(LatLng(
          _posicionDestinoCliente.value.latitude,
          _posicionDestinoCliente.value.longitude));
      pedido.value.direccionUsuario = direccion.value;

      //Mostrar el marcador del cliente en el mapa
      // _agregarMarcadorCliente(_posicionCliente.value);

      //Cargar los datos de la notificacion
      _cargarListaNotificaciones();
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

    cargandoDatosDelPedidoRealizado.value = false;
  }

  //Diseno mapa
  void onMapaCreado(GoogleMapController controller) {
    controller.showMarkerInfoWindow(MarkerId(id));

    controladorGoogleMap = controller;
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
        infoWindow: InfoWindow(
          title: pedido.value.estadoPedidoUsuario,
          snippet: ('\$${pedido.value.totalPedido} de ') +
              (pedido.value.cantidadPedido > 1
                  ? '${pedido.value.cantidadPedido} cilindros'
                  : '${pedido.value.cantidadPedido} cilindro') +
              ' para ${pedido.value.direccionUsuario}',
        ));

    marcadoresAux[markerId] = marker;
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

  Future<void> _cargarListaNotificaciones() async {
    try {
      //CARGAR DATOS DEL PEDIDO
      List<Notificacion>? aux =
          await _notificacionRepository.getNotificacionesPorField(
              field: "idPedidoNotificacion", dato: pedido.value.idPedido!);

      if (aux!.length.toInt() > 0) {
        _notificaciones.clear();

        for (var element in aux) {
          _notificaciones.add(
              "${element.tituloNotificacion}, por ${element.textoNotificacion},${formatoHoraFecha(element.fechaNotificacion)}");
        }
      }
    } catch (e) {
      //
    }
  }

//
  RxBool cargandoDetalle = false.obs;
  final Rx<EstadoDelPedido> _estadoPedido1 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  final Rx<EstadoDelPedido> _estadoPedido3 = EstadoDelPedido(
          idEstado: "null", fechaHoraEstado: Timestamp.now(), idPersona: "")
      .obs;
  Rx<EstadoDelPedido> get estadoPedido1 => _estadoPedido1;
  Rx<EstadoDelPedido> get estadoPedido3 => _estadoPedido3;

  //El estadoPedido2 se usa por el repartidor
  Future<void> cargarDetalle() async {
    PedidoModel? pedidoAux = pedido.value;

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
          uid: pedidoAux.idPedido!, field: "estadoPedido1");
      var aux3 = await _pedidoRepository.getEstadoPedidoPorField(
          uid: pedidoAux.idPedido!, field: "estadoPedido3");

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
      _cargarPaginaDetalle(pedidoAux);
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
          formatoHoraFecha: formatoHoraFecha,
          estadoPedido1: estadoPedido1,
          estadoPedido3: estadoPedido3,
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

  //
  Future<String> _getDireccionXLatLng(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
    Placemark lugar = placemark[0];

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

  Future<void> _cargarDireccionDestinoDelPedido() async {
    direccion.value = await _getDireccionXLatLng(LatLng(
        _posicionDestinoCliente.value.latitude,
        _posicionDestinoCliente.value.longitude));
    pedido.value.direccionUsuario = direccion.value;

    // cargarPuntosDeLaRutaDelPedido();
  }

  //Variables para la vista previa de la ruta en tiempo real -1.325901, -78.870296
  /*LatLng sourceLocation = LatLng(-1.353455, -78.866747);
  LatLng destination = LatLng(-1.325901, -78.870296);
*/
  static const google_api_key = 'AIzaSyAQMbEr7dS-0H_AUbuggKw3PhHyxDfJ8JA';

  //Varriables de los iconos para marcadores del mapa
  BitmapDescriptor iconoOrigenMarcadorVehiculoRepartidor =
      BitmapDescriptor.defaultMarker;
  BitmapDescriptor iconoDestinoMarcadorPedidoCliente =
      BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void cargarIconosMarcadoresDelMapa() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/camiongasjm.png")
        .then(
      (icon) {
        iconoOrigenMarcadorVehiculoRepartidor = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/icons/marcadorCliente.png")
        .then(
      (icon) {
        iconoDestinoMarcadorPedidoCliente = icon;
      },
    );

    //
    var markerId = const MarkerId('MarcadorPedidoCliente');
    final marker = Marker(
        markerId: markerId,
        position: LatLng(_posicionDestinoCliente.value.latitude,
            _posicionDestinoCliente.value.longitude),
        icon: iconoDestinoMarcadorPedidoCliente);
    marcadoresAux[markerId] = marker;
  }

  //Metodo para dibujar la dirección de la ruta
  final RxList<LatLng> _polylineCoordinates = <LatLng>[].obs;
  RxList<LatLng> get polylineCoordinates => _polylineCoordinates;

  void cargarPuntosDeLaRutaDelPedido() async {
    print("aaaaaaaaaaaaaaaaaaaaaaa");
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key, // Your Google Map Key
      PointLatLng(posicionOrigenVehiculoRepartidor.value.latitude,
          posicionOrigenVehiculoRepartidor.value.longitude),
      PointLatLng(posicionDestinoPedidoCliente.value.latitude,
          posicionDestinoPedidoCliente.value.longitude),
    );
    if (result.points.isNotEmpty) {
      List<LatLng> aux = [];
      for (var point in result.points) {
        aux.add(
          LatLng(point.latitude, point.longitude),
        );

        print(point);
      }

      _polylineCoordinates.value = aux;
      // setState(() {});
    }

    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
  }

//
  final Rx<LatLng> posicionOrigenVehiculoRepartidor =
      const LatLng(-12.122711, -77.027475).obs;

  //
  Future<void> getUbicacionUsuario() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    posicionOrigenVehiculoRepartidor.value =
        LatLng(position.latitude, position.longitude);

    Geolocator.getPositionStream().listen((event) async {
      //
      double rotation = Geolocator.bearingBetween(
          posicionOrigenVehiculoRepartidor.value.latitude,
          posicionOrigenVehiculoRepartidor.value.longitude,
          event.latitude,
          event.longitude);

      //
      rotacionMarcadorVehiculoRepartidor.value = rotation;
      //
      posicionOrigenVehiculoRepartidor.value =
          LatLng(event.latitude, event.longitude);

      //  cargarPuntosDeLaRutaDelPedido();
      //
      if (controladorGoogleMap != null) {
        final zoom = await controladorGoogleMap!.getZoomLevel();
        final cameraUpdate = CameraUpdate.newLatLngZoom(
            LatLng(
              event.latitude,
              event.longitude,
            ),
            zoom);

        //
        controladorGoogleMap?.animateCamera(cameraUpdate);
      }
    });
  }
}
      //

/*
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _posicionInicialCliente.value =
          LatLng(position.latitude, position.longitude);
*/
      //  direccionTextController.text = placemark[0].name!;
      // direccion.value = placemark[0].name!;

      //  _agregarMarcadorCliente(    _posicionInicialCliente.value, placemark[0].name!);
      /*
      _mapaController
          ?.moveCamera(CameraUpdate.newLatLng(_posicionInicialCliente.value));*/

      //  notifyListeners();
 
  //Actualizaciones de ubicación en tiempo real en el mapa


