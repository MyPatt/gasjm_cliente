import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
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

  //Obtener distancia entre el pedido y el repartidor
  RxInt distanciaRuta = (0).obs;

  //
  String idPedido = '';

  //METODOS PROPIOS GETX
  @override
  void onInit() {
    super.onInit();
    //Obtener  datos del pedido  realizado
    Future.wait([_cargarDatosDelPedidoRealizado()]);

    //Obtiene el nombre de direccion del destino del pediod a partir de la posicion en LatLng
    _cargarDireccionDestinoDelPedido();

    //Se asigna los iconos personalizados a los marcadores del mapa (detinopedido y vehiculo)
    cargarIconosMarcadoresDelMapa();
  }

//Metodo para actualizar la variable del estado de la memoria, si ya no esta en true debe volver a cargar el inicio  cancelar el pedido
  Future<void> _actualizarPedidoCanceladoEnFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("pedido_esperando", false);

    prefs.remove("pedido_esperando");
    //
    Get.offAllNamed(AppRoutes.inicio);
  }

  //Metodo que obtiene el ultimo pedido realizado y aun no se a finalizado

  Future<void> _cargarDatosDelPedidoRealizado() async {
    try {
      cargandoDatosDelPedidoRealizado.value = true;

      //CARGAR DATOS DEL PEDIDO
      var aux = await _getDatosPedido();
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
      print('*****${pedido.value.idPedido}');
      idPedido = pedido.value.idPedido!;
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

//al acualizar  la ubicacion de un repartidor cuando se ha cambiado se muestra en el mapa
  Stream<QuerySnapshot> getUbicacionesDeRepartidores() {
    var snapshot = FirebaseFirestore.instance
        .collection('ubicacionRepartidor')
        //   .doc('IXvTa9j5pZbYjpC0Ttgh0OXNcCD3')
        // .doc(_.pedido.value.idRepartidor)
        .snapshots();
    return snapshot;
  }

  //Diseno mapa
  void onMapaCreado(GoogleMapController controller) {
    //controller.showMarkerInfoWindow(MarkerId(id));

    controladorGoogleMap = controller;
    controller.setMapStyle(estiloMapa);
  }

  //
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
  Future<void> actualizarEstadoPedido() async {
    String idPedido = pedido.value.idPedido!;

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
      await _actualizarPedidoCanceladoEnFalse();
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

//Cargar pagina de notifiaciones
  void cargarPaginaNotifiaciones() {
    Get.toNamed(AppRoutes.notificacion, arguments: pedido.value);
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

  //Variables para la vista previa de la ruta en tiempo real
  static const googleapikey = 'AIzaSyAQMbEr7dS-0H_AUbuggKw3PhHyxDfJ8JA';

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
  }

  //Metodo para dibujar la dirección de la ruta
  final RxList<LatLng> _polylineCoordinates = <LatLng>[].obs;
  RxList<LatLng> get polylineCoordinates => _polylineCoordinates;

  void cargarPuntosDeLaRutaDelPedido() async {
    print("aaaaaaaaaaaaaaaaaaaaaaa");
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleapikey, // Your Google Map Key
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

  //Obtener distancia entre el pedido y el repartidor
  Future<void> getDistanciaPedidoYrepartidor() async {
    distanciaRuta.value = Geolocator.distanceBetween(
            posicionOrigenVehiculoRepartidor.value.latitude,
            posicionOrigenVehiculoRepartidor.value.longitude,
            pedido.value.direccion.latitud,
            pedido.value.direccion.longitud)
        .toInt();

    //
    /*
    try {
      print('?????????');
      Dio dio = Dio();
      print('????????');
      var response = await dio.get(
          "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=$google_api_key");
      print('??  ?');
      print(response.data);
    } catch (e) {
      print('888888888888');
      print(e);
    }*/
  }

  //para ejecutar cuando se actualiza el pedido
  Stream<QuerySnapshot> getNotificacion() {
    var snapshot = FirebaseFirestore.instance
        .collection('notificacion')
        .where('idPedidoNotificacion', isEqualTo: pedido.value.idPedido)
        .orderBy("fechaNotificacion", descending: true)
        .snapshots();

    return snapshot;
  }
}
