import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:location/location.dart' as loc;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class UbicacionController extends GetxController {
  //
  final cargando = RxBool(false);
  //PermissionStatus _status;

  cargarIdentificacion() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed(AppRoutes.identificacion);
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
          duracion: const Duration(seconds: 4),
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
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
    }
    return false;
  }
}
