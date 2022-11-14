import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/map_style.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:gasjm/app/data/repository/pedido_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/data/repository/producto_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final RxDouble precioGlp = 1.60.obs;
//Repositorio para horario
  final _horarioRepository = Get.find<HorarioRepository>();

  /* Variables para el form */
  final formKey = GlobalKey<FormState>();
  final direccionTextoController = TextEditingController();
  final notaTextoController = TextEditingController();
  var cantidadTextoController = TextEditingController();
  Rx<TextEditingController> totalTextoController = TextEditingController().obs;
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
    Future.wait([
      getHorario(),
    ]);
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

  //Obtener informacion del producto
  Future<void> getPrecioProducto() async {
    precioGlp.value = await _productoRepository.getPrecioPorProducto(id: "glp");
  }

  //Obtener informacion del horario
  Timestamp horarioApertura = Timestamp.now();
  Timestamp horarioActual = Timestamp.now();
  Timestamp horarioCierre = Timestamp.now();
  RxString cadenaHorarioAtencion = ''.obs;
  Future<void> getHorario() async {
    //Obtener hora actual
    horarioActual = Timestamp.now();
    DateTime horaActualConvertida = DateTime.fromMillisecondsSinceEpoch(
        horarioActual.millisecondsSinceEpoch);
    //Numero del dia de la semana 1=lunes
    int idDia = horaActualConvertida.weekday;
    //Datos del horario desde firestore
    HorarioModel horarioAtencion =
        await _horarioRepository.getHorarioPorIdDia(idDiaHorario: idDia);
    //

    //Convertir horario  del dia
    int horaApertura = int.parse(horarioAtencion.aperturaHorario.split(':')[0]);
    int minutoApertura =
        int.parse(horarioAtencion.aperturaHorario.split(':')[1]);
    //
    int horaCierre = int.parse(horarioAtencion.cierreHorario.split(':')[0]);
    int minutoCierre = int.parse(horarioAtencion.cierreHorario.split(':')[1]);
    //
    DateTime aperturaAux = DateTime(
        horaActualConvertida.year,
        horaActualConvertida.month,
        horaActualConvertida.day,
        horaApertura,
        minutoApertura);
    //
    DateTime cierreAux = DateTime(
        horaActualConvertida.year,
        horaActualConvertida.month,
        horaActualConvertida.day,
        horaCierre,
        minutoCierre);
    //
    horarioApertura = Timestamp.fromDate(aperturaAux);
    horarioCierre = Timestamp.fromDate(cierreAux);

    //Horario de atencion en texto
    cadenaHorarioAtencion.value =
        "${horarioAtencion.aperturaHorario} - ${horarioAtencion.cierreHorario}";
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
      final totalPedido = double.parse(totalTextoController.value.text);
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

      Mensajes.showGetSnackbar(
          titulo: "Mensaje",
          mensaje: "Su pedido se registro con éxito.",
          icono: const Icon(
            Icons.check_circle_outline_outlined,
            color: Colors.white,
          ));
      _cargarProcesoPedido();
    } on FirebaseException {
      Mensajes.showGetSnackbar(
          titulo: "Alerta",
          mensaje:
              "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.",
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: "Alerta",
          mensaje:
              "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.",
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
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
  }

  cargarLogin() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.offNamed(AppRoutes.identificacion);
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
    }
  }

  /*  DIA PARA AGENDAR EN FORM PEDIR GAS */

  //
  void _loadDatosIniciales() {
    direccionTextController.text = "Buscando dirección...";
    diaDeEntregaPedidoController.value.text = "Ahora";
    cantidadTextoController.text = "1";
    totalTextoController.value.text = '${precioGlp.value}';
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
      Get.offAllNamed(AppRoutes.procesopedido);
      //Guardar estado del cliente de forma local

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("pedido_esperando", true);
    } catch (e) {
      throw Exception(
          "Ha ocurrido un error, por favor inténtelo de nuevo más tarde.");
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
      totalTextoController.value.text = "0.00";
      return;
    }

    double total =
        double.parse(valor) * double.parse(precioGlp.value.toStringAsFixed(2));

    totalTextoController.value.text = total.toString();
  }

//Volver a obtener la hora actual y calculsr el total con el precio de firestore
  void actualizarDatosDelForm() {
    horarioActual = Timestamp.now();
    totalTextoController.value.text =
        '${precioGlp.value * (cantidadTextoController.text.isEmpty ? 0 : double.parse(cantidadTextoController.text))}';
  }
}


//TODO: Horarios de atencion