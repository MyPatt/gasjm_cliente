import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

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
}
