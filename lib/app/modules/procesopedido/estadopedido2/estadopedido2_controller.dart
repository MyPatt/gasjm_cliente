import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:intl/intl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class EstadoPedido2Controller extends GetxController {
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

  //Posicion del destino final para entregar el pedido que es el cliente, inicializado
  final Rx<LatLng> _posicionDestinoCliente =
      const LatLng(-0.2053476, -79.4894387).obs;
  Rx<LatLng> get posicionDestinoPedidoCliente =>
      _posicionDestinoCliente.value.obs;

  //Variable observable que muestra la direccion/ destino para entregar el pedido, esto se visualiza en un modal
  RxString direccion = ''.obs;

  //Obtener distancia entre el pedido y el repartidor
  RxInt distanciaRuta = (0).obs;

  //METODOS PROPIOS GETX
  @override
  Future<void> onInit() async {
    super.onInit();
    //Obtener  datos del pedido  realizado
    //Future.wait([cargarDatosDelPedidoRealizado()]);

    //Obtiene el nombre de direccion del destino del pediod a partir de la posicion en LatLng
    //_cargarDireccionDestinoDelPedido();

    //await initNotificacion();
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

  Future<LatLng> cargarDatosDelPedidoRealizado() async {
    try {
      cargandoDatosDelPedidoRealizado.value = true;

      //CARGAR DATOS DEL PEDIDO
      var aux = await _getDatosPedido();
      String _nombreCliente = _personaRepository.nombreUsuarioActual;
      var estado = await _getNombreEstado(aux.idEstadoPedido);
      print('!!!!!$estado');
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
    return LatLng(
        pedido.value.direccion.latitud, pedido.value.direccion.longitud);
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
    //  onStyleLoaded();
    // Get.toNamed(AppRoutes.notificacion, arguments: pedido.value);
    onStyleLoadedCallback();
    /*  controller.addSymbol(SymbolOptions(
      geometry: posicionDestinoPedidoCliente.value,
      iconImage: "assetImage",
    ));*/
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

//////
  ///
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///Inicializar notificacion
  Future<void> initNotificacion() async {
    //Inicializacion Android
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    //Inicializacion ios
    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    //Inicializacion configuracion
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    configureLocalTimeZone();
    //Los ajustes de inicialización se inicializan después de configurarlos
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  ///Mostrar notificacion  por fecha y hora
  Future<void> showNotificacion(
    BuildContext context,
    int id,
    String titulo,
    String texto,
    DateTime fechaActual,
    DateTime fechaProgramada,
  ) async {
//
    if (fechaProgramada
        .isAfter(fechaActual.subtract(const Duration(seconds: 10)))) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id, null,
        //titulo,
        '$titulo por $texto',
        //Programar la notificación para que se muestre después de 1 segundos..add(const Duration(seconds: 1))
        tz.TZDateTime.now(tz.local).add(const Duration(milliseconds: 5)),

        const NotificationDetails(
          //Detalle Android
          android: AndroidNotificationDetails('main_channel_id',
              'main_channel_name', 'main_channel_description',
              importance: Importance.max, priority: Priority.max),
          //Detalle iOS
          iOS: IOSNotificationDetails(
            sound: 'default.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),

        //Tipo de interpretación del tiempo
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle:
            true, //Para mostrar la notificación incluso cuando la aplicación está cerrada
      );
    }

//
    if (titulo == 'Pedido finalizado' ||
        titulo == 'Pedido cancelado' ||
        titulo == 'Pedido rechazado') {
      Future.delayed(const Duration(seconds: 1));
      //Mensajes.showGetSnackbar(titulo: 'Gas J&M', mensaje: titulo);
      _actualizarPedidoCanceladoEnFalse();
      /*  Future.delayed(const Duration(seconds: 1));
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return //Obx
              (
                  //() =>
                  ModalAlert(
                      titulo: titulo,
                      mensaje: '¿Retornar a la página de inicio?',
                      icono: Icons.cancel_outlined,
                      onPressed: () => _actualizarPedidoCanceladoEnFalse()));
        },
      );*/
    }
  }

//
  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    var detroit = tz.getLocation('America/Guayaquil');

    tz.TZDateTime.from(DateTime.now(), detroit);
    tz.setLocalLocation(tz.getLocation(detroit.name));
  }

  //

  //////////////////////////////////////
  late MapboxMapController controller;

  onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  void _onStyleLoadedCallback() async {
    addImageFromAsse('assetImage', 'assets/icons/camiongasjm.png');
/*
    await controller.addSymbol(SymbolOptions(
      geometry: posicionDestinoPedidoCliente.value,
      iconSize: 0.2,
      iconImage: "assets/icon/food.png",
    ));*/

    // _addSourceAndLineLayer(0, false);
  }

  Future<void> addImageFromAsse(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();

    return controller.addImage(name, list);
  }

  onStyleLoaded() async {
    controller.addSymbol(
      SymbolOptions(
          geometry: posicionDestinoPedidoCliente.value,
          iconImage: "bar-11",
          iconSize: 5),
    );

    // _addSourceAndLineLayer(0, false);
  }

  //
  onStyleLoadedCallback() async {
    await controller.addSymbol(
      SymbolOptions(
        geometry: posicionOrigenVehiculoRepartidor.value,
        iconSize: 0.2,
        iconImage: "assets/icons/camiongasjm.png",
      ),
    );

    // _addSourceAndLineLayer(0, false);
  }
}
