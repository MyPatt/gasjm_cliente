//Estados de sutenticacion
import 'dart:async';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;

enum EstadosDeAutenticacion { sesionNoIniciada, sesionIniciada }

//Controlador de autenticacion que rige en toda la app
class AutenticacionController extends GetxController {
  final _autenticacionRepository = Get.find<AutenticacionRepository>();
  late StreamSubscription _autenticacionSuscripcion;

  final Rx<EstadosDeAutenticacion> autenticacionEstado =
      Rx(EstadosDeAutenticacion.sesionNoIniciada);

  final Rx<AutenticacionUsuario?> autenticacionUsuario = Rx(null);

  @override
  void onInit() async {
    // TSolo para testear. Permitir la pantalla de splash luego unos pocos segundos
    await Future.delayed(const Duration(seconds: 2));
    //Testea la suscripcion del cambio de estado de inicio sesion para ir a la pagina de introduccion u login
    _autenticacionSuscripcion = _autenticacionRepository
        .enEstadDeAutenticacionCambiado
        .listen(_estadoAutenticacionCambiado);

    super.onInit();
  }

  Future<void> _estadoAutenticacionCambiado(
      AutenticacionUsuario? usuario) async {
    //Verificar si el usuario ha iniciado sesion?,
    //si es = null no se ha iniciado y se dirije a la pagina de permiso de ubicacion
    if (usuario == null) {
      autenticacionEstado.value = EstadosDeAutenticacion.sesionNoIniciada;
      Get.offAllNamed(AppRoutes.ubicacion);

      //diferente de null cargar la pagina de inicio
    } else {
      //1. Actualizar estado de autenticacion
      autenticacionEstado.value = EstadosDeAutenticacion.sesionIniciada;

      //2. ver que la aplicacion tenga permiso de ubicacion
      switch (await askGpsAccess()) {
        case true:
          await verificarpPedidoEnProceso();

          break;

        default:
          //Verificar si el cliente no tiene un pedido en espera
          await verificarpPedidoEnProceso();
      }
    }
    autenticacionUsuario.value = usuario;
  }

  Future<void> verificarpPedidoEnProceso() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool pedidoEsperando = prefs.getBool("pedido_esperando") ?? false;

    if (pedidoEsperando == true) {
      Get.offAllNamed(AppRoutes.procesopedido);
    } else {
      Get.offAllNamed(AppRoutes.inicio);
    }
  }

  Future<void> cerrarSesion() async {
    await _autenticacionRepository.cerrarSesion();
  }

  @override
  void onClose() {
    _autenticacionSuscripcion.cancel();
    super.onClose();
  }

  //
  Future<bool> askGpsAccess() async {
    var aux = false;

    //Variable para verificar el permiso de la aplicacion para acceder al dispositivo
    final permisoDeUbicacionParaAplicacion =
        await Permission.location.request();

    switch (permisoDeUbicacionParaAplicacion) {

      //Permiso otorgado
      case PermissionStatus.granted:
        aux = await obtenerEstadoUbicacionDispositivo();
        break;
      // se supone que es denegado
      default:
        loc.Location location = loc.Location();

        var aux1 = await location.requestPermission();
        var aux2 = await obtenerEstadoUbicacionDispositivo();
        if (aux1 == PermissionStatus.granted) {
          if (aux2) {
            aux = true;
          }
        }
    }

    return aux;
  }

  Future<bool> obtenerEstadoUbicacionDispositivo() async {
    //Variable para verificar si el dipositovo tiene habilitado la ubicacion
    loc.Location location = loc.Location();

    bool habilitadoUbicacionDispositivo = await location.serviceEnabled();

    //ubicacion deshabilitado
    if (!habilitadoUbicacionDispositivo) {
      //Mostrar alert para habilitar
      bool habilitadoUbicacion = await location.requestService();

      //Verificar si se ha habilitado
      if (habilitadoUbicacion) {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
