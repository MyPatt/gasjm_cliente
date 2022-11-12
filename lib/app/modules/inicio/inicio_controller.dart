import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/producto_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InicioController extends GetxController {
  //Repositorio de usuario
  final _usuarioRepository = Get.find<PersonaRepository>();

  /* Variables para obtener datos del usuario */
  Rx<PersonaModel?> usuario = Rx(null);
//
  RxString imagenUsuario = ''.obs;
  //Repositorio de pedidos
  final _pedidoRepository = Get.find<PedidoRepository>();
  final _personaRepository = Get.find<PersonaRepository>();

  //Repositorio de productos
  final _productoRepository = Get.find<ProductoRepository>();
  final precioGlp = 1.60.obs;

  /* Variables para el form */
  final formKey = GlobalKey<FormState>();
  final direccionTextoController = TextEditingController();
  final notaTextoController = TextEditingController();
  var cantidadTextoController = TextEditingController();
  var totalTextoController = TextEditingController();
  final diaDeEntregaPedidoController = TextEditingController().obs;
  final itemSeleccionadoDia = 0.obs;

  final grupoSeleccionadoFecha = "Ahora".obs;

  // //Mientras se inserta el pedido mostrar circuleprobres se carga si o no
  final procensandoElNuevoPedido = RxBool(false);

  /* Variables para google maps */
  TextEditingController direccionTextController = TextEditingController();

  GoogleMapController? _mapaController;

  final Rx<LatLng> _posicionInicialCliente =
      const LatLng(-12.122711, -77.027475).obs;

  final direccion = 'Buscando dirección...'.obs;

  Rx<LatLng> get posicionInicialCliente => _posicionInicialCliente.value.obs;

  final Map<MarkerId, Marker> _marcadores = {};
  Set<Marker> get marcadores => _marcadores.values.toSet();

  late String id = 'MakerIdCliente';
/*METODOS PROPIOS */
  @override
  void onInit() {
    //Obtiene datos del usuario que inicio sesion
    _cargarFotoPerfil();
    //Obtiene ubicacion actual del dispositivo

    //Obtener datos del producto

    Future.wait([
      getUsuarioActual(),
      getUbicacionUsuario(),
      getPrecioProducto(),
    ]);

    super.onInit();
  }

  @override
  void onReady() {
    //Cargar datos iniciales para el formulario
    _loadDatosIniciales();
    super.onReady();
  }

  @override
  void onClose() {
    direccionTextoController.dispose();
    diaDeEntregaPedidoController.value.dispose();
    cantidadTextoController.dispose();

    notaTextoController.dispose();

    super.onClose();
  }

  /* OTROS METODOS */
/*METODO PARA CARGAR DATOS DE INICIO */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

//Obtener informacion del cliente conectado
  Future<void> getUsuarioActual() async {
    usuario.value = await _usuarioRepository.getUsuario();
  }

  //Obtener informacion del cliente conectado
  Future<void> getPrecioProducto() async {
    precioGlp.value = await _productoRepository.getPrecioPorProducto(id: "glp");
  }

//Metodos para insertar un nuevo pedido
  insertarPedido() async {
    try {
      procensandoElNuevoPedido.value = true;
      const idProducto = "glp";
      final idCliente = usuario.value?.cedulaPersona ?? '';
      const idRepartidor = "SinAsignar";
      final direccion = Direccion(
          latitud: _posicionInicialCliente.value.latitude,
          longitud: _posicionInicialCliente.value.longitude);

      const idEstadoPedido = 'estado1';
      final diaEntregaPedido = diaDeEntregaPedidoController.value.text;
      final notaPedido = notaTextoController.text;
      final cantidadPedido = int.parse(cantidadTextoController.text);
      final totalPedido = double.parse(totalTextoController.text);
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
        totalPedido: totalPedido,
        cantidadPedido: cantidadPedido,
      );

      await _pedidoRepository.insertPedido(pedidoModel: pedidoModel);

      _cargarProcesoPedido();
      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Su pedido se registro con éxito.",
          icono: const Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.white,
          ));
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: "Error",
          mensaje: "Se produjo un error inesperado.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
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
      Get.offNamed(AppRoutes.identificacion);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    cargarLogin;
  }

  /*  DIA PARA AGENDAR EN FORM PEDIR GAS */

  //
  void _loadDatosIniciales() {
    direccionTextController.text = "Buscando dirección...";
    diaDeEntregaPedidoController.value.text = "Ahora";
    cantidadTextoController.text = "1";
    totalTextoController.text = precioGlp.value.toString();
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

/* GOOGLE MAPS */
  GoogleMapController? get mapController => _mapaController;

  void getMovimientoCamara() async {
    List<Placemark> placemark = await placemarkFromCoordinates(
        _posicionInicialCliente.value.latitude,
        _posicionInicialCliente.value.longitude,
        localeIdentifier: "en_US");
    direccionTextController.text = placemark[0].name!;
 
 
  }

  Future<void> getUbicacionUsuario() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      //si la ubicacion esta deshabilitado tiene activarse
      await Geolocator.openLocationSettings();
      return Future.error('Servicio de ubicación deshabilitada.');
    } else {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          //Si la ubicacion sigue dehabilitado mostrar sms
          return Future.error('Permiso de ubicación denegado.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        //Permiso denegado por siempre
        return Future.error(
            'Permiso de ubicación denegado de forma permanente.');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _posicionInicialCliente.value =
          LatLng(position.latitude, position.longitude);

      direccionTextController.text = placemark[0].name!;
      direccion.value = placemark[0].name!;

      _agregarMarcadorCliente(
          _posicionInicialCliente.value, placemark[0].name!);
      _mapaController
          ?.moveCamera(CameraUpdate.newLatLng(_posicionInicialCliente.value));

      //  notifyListeners();
    }
  }

  void onMapaCreado(GoogleMapController controller) {
    _mapaController = controller;
    controller.setMapStyle(estiloMapa);
    // notifyListeners();
  }

  Future<void> _agregarMarcadorCliente(
      LatLng posicion, String direccion) async {
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

  void onCameraMove(CameraPosition position) async {
    _posicionInicialCliente.value = position.target;

    final markerId = MarkerId(id);

    final marker = _marcadores[markerId];

    BitmapDescriptor _marcadorCliente = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icons/marcadorCliente.png",
    );

    Marker updatedMarker = marker?.copyWith(
            positionParam: position.target, iconParam: _marcadorCliente) ??
        Marker(
          markerId: markerId,
        );

    _marcadores[markerId] = updatedMarker;

  
  }

  void onChangedCantidad(valor) {
    if (cantidadTextoController.text.isEmpty) {
      totalTextoController.text = "0.00";
      return;
    }

    double total =
        double.parse(valor) * double.parse(precioGlp.value.toStringAsFixed(2));

    totalTextoController.text = total.toString();
    if (valor.length > 1) {
      cantidadTextoController.text = valor;
    }
  }
}


//TODO: Horarios de atencion