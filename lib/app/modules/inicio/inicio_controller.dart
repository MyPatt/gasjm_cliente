import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class InicioController extends GetxController {
  @override
  void onInit() {
    //Obtiene datos del usuario que inicio sesion
    getUsuarioActual();
    //Obtiene ubicacion actual del dispositivo
    getLocation();
    //
    _cargarDiaYCantidadInicial();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _markersController.close();
    streamSubscription.cancel();
    direccionTextoController.dispose();
    diaDeEntregaPedidoController.value.dispose();
    cantidadTextoController.dispose();

    notaTextoController.dispose();

    super.onClose();
  }

  /* DATOS DEL USUARIO */
  /* Variables para obtener datos del usuario */
  //Repositorio de usuario
  final _userRepository = Get.find<MyUserRepository>();
  //
  Rx<UsuarioModel?> usuario = Rx(null);
  Future<void> getUsuarioActual() async {
    usuario.value = await _userRepository.getUsuario();
  }

  /* FORMULARIO PARA PEDIR EL GAS */
  //Variables para el form
  final formKey = GlobalKey<FormState>();
  final direccionTextoController = TextEditingController();
  final notaTextoController = TextEditingController();
  var cantidadTextoController = TextEditingController();
  //Repositorio de pedidos
  final _pedidoRepository = Get.find<PedidoRepository>();
  //Metodos para insertar un nuevo pedido
  // //Mientras se inserta el pedido mostrar circuleprobres se carga si o no
  final procensandoElNuevoPedido = RxBool(false);
  insertarPedido() async {
    try {
      procensandoElNuevoPedido.value = true;
      const idProducto = "glp";
      final idCliente = usuario.value?.cedula ?? '';
      const idRepartidor = "SinAsignar";
      final direccion = Direccion(
          latitud: posicionPedido.value.latitude,
          longitud: posicionPedido.value.longitude);

      const idEstadoPedido = 'estado1';
      final diaEntregaPedido = diaDeEntregaPedidoController.value.text;
      final notaPedido = notaTextoController.text;
      final cantidadPedido = int.parse(cantidadTextoController.text);
      //
      PedidoModel pedidoModel = PedidoModel(
        idProducto: idProducto,
        idCliente: idCliente,
        idRepartidor: idRepartidor,
        direccion: direccion,
        idEstadoPedido: idEstadoPedido,
        fechaHoraPedido: Timestamp.now(),
        diaEntregaPedido: diaEntregaPedido,
        notaPedido: notaPedido,
        totalPedido: 555555,
        cantidadPedido: cantidadPedido,
      );

      await _pedidoRepository.insertPedido(pedidoModel: pedidoModel);
      _inicializarDatos();
      //Get.back();
      _cargarProcesoPedido();
      Get.snackbar('Nuevo pedido', 'Su pedido se registro con éxito.',
       
          backgroundColor: AppTheme.blueDark,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 0);
    } on FirebaseException catch (e) {
      Get.snackbar('Mensaje', e.message ?? 'Se produjo un error inesperado.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppTheme.blueDark,
          colorText: Colors.white,
          borderRadius: 0);
    }
    procensandoElNuevoPedido.value = false;
  }

/* MANEJO DE RUTAS DEL MENU */
  //Ir a la pantalla de agenda
  cargarAgenda() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.agenda);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  cargarLogin() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    cargarLogin;
  }

  /* GOOGLE MAPS */
  //Variables

  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  //
  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  //
  //final posicionInicial = LatLng(-0.2053476, -79.4894387).obs;
  final posicionInicial = const LatLng(-0.2053476, -79.4894387).obs;
  final posicionMarcadorCliente = const LatLng(-0.2053476, -79.4894387).obs;
  final posicionPedido = const LatLng(-0.2053476, -79.4894387).obs;

  //final initialCameraPosition =    const CameraPosition(target: LatLng(-0.2053476, -79.4894387), zoom: 15);

  //Cambiar el estilo de mapa
  onMapaCreated(GoogleMapController controller) {
    controller.setMapStyle(estiloMapa);

    //Cargar marcadores
    cargarMarcadores();
  }

//
  void onTap(LatLng position) {
    posicionInicial.value = position;
    posicionMarcadorCliente.value = position;
    // final id = _markers.length.toString(); para generar muchos markers
//Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID
    final id = usuario.value?.cedula ?? 'MakerIdCliente';

    final markerId = MarkerId(id);

    final marker = Marker(
        markerId: markerId,
        position: posicionInicial.value,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onDragEnd: (newPosition) {
          posicionInicial.value = newPosition;
          _getDireccionXLatLng(newPosition);
        });
//

    _markers.clear();
//
    _markers[markerId] = marker;
    _getDireccionXLatLng(posicionMarcadorCliente.value);
  }

  // UBICACION ACTUAL

  //Variables
  var direccion = 'Buscando dirección...'.obs;

  late StreamSubscription<Position> streamSubscription;

  //Obtener ubicacion
  RxBool servicioHbilitado = false.obs;

  getLocation() async {
    LocationPermission permiso;

    //Esta habilitado el servicio?
    servicioHbilitado.value = await Geolocator.isLocationServiceEnabled();
    if (!servicioHbilitado.value) {
      //si la ubicacion esta deshabilitado tiene activarse
      await Geolocator.openLocationSettings();
      return Future.error('Servicio de ubicación deshabilitada.');
    }
    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        //Si la ubicacion sigue dehabilitado mostrar sms
        return Future.error('Permiso de ubicación denegado.');
      }
    }
    if (permiso == LocationPermission.deniedForever) {
      //Permiso denegado por siempre
      return Future.error('Permiso de ubicación denegado de forma permanente.');
    }

    //Al obtener el permiso de ubicacion se accede a las coordenadas de la posicion
    streamSubscription =
        Geolocator.getPositionStream().listen((Position posicion) {
      posicionInicial.value = LatLng(posicion.latitude, posicion.longitude);
    });
  }

  String _getDireccion(Placemark lugar) {
    //
    if (lugar.subLocality?.isEmpty == true) {
      return lugar.street.toString();
    } else {
      return '${lugar.street}, ${lugar.subLocality}';
    }
  }

  Future<void> _getDireccionXLatLng(LatLng posicion) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(posicion.latitude, posicion.longitude);
    Placemark lugar = placemark[0];

//
    direccion.value = _getDireccion(lugar);
    direccionTextoController.text = direccion.value;
    posicionPedido.value = posicion;
  }

  Set<Marker> marcadores = {};

  void cargarMarcadores() {
    //Marcador cliente
    posicionMarcadorCliente.value = posicionInicial.value;

//Actualizar las posiciones del mismo marker la cedula del usuario conectado como ID
    final id = usuario.value?.cedula ?? 'MakerIdCliente';
//
    final markerId = MarkerId(id);
    // marcadores.add(Marker(
    final marker = Marker(
        markerId: markerId,
        position: posicionMarcadorCliente.value,
        draggable: true,
        //212.2
        icon: BitmapDescriptor.defaultMarkerWithHue(208),
        onDragEnd: (newPosition) {
          // ignore: avoid_print
          posicionMarcadorCliente.value = newPosition;
          _getDireccionXLatLng(posicionMarcadorCliente.value);
        });
    _markers[markerId] = marker;
    //
    _getDireccionXLatLng(posicionMarcadorCliente.value);
  }

  /*  DIA PARA AGENDAR EN FORM PEDIR GAS */
  final diaDeEntregaPedidoController = TextEditingController().obs;
  final itemSeleccionadoDia = 0.obs;
  //
  void _cargarDiaYCantidadInicial() {
    diaDeEntregaPedidoController.value.text = "Ahora";
    cantidadTextoController.text = "1";
  }

  final diaInicialSeleccionado = 0.obs;
  void guardarDiaDeEntregaPedido() {
    if (itemSeleccionadoDia.value == 0) {
      diaDeEntregaPedidoController.value.text = "Ahora";
      diaInicialSeleccionado.value = 0;
    } else {
      diaDeEntregaPedidoController.value.text = "Mañana";
      diaInicialSeleccionado.value = 1;
    }
  }

//Cuando el pedido se crea
  _cargarProcesoPedido() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.procesopedido);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void _inicializarDatos() {
    //TODO: creo que no
  }

//TODO: Obtener el horario desde la BD
//TODO: Ajustar horario

//TODO: Optimizar variables para fecha y hora
//TODO: Horarios de atencion
//TODO: FechaHoraActual para comparar que no sea local sino de red

}
