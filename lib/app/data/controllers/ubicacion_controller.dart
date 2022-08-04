//Controlador global para el permiso de ubicacion de l dispositivo

import 'dart:async';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

enum EstadosDeUbicacion { ubicacionNoPermitida, ubicacionPermitida }

//Controlador de ubicacion que rige en toda la app
class UbicacionGloablController extends GetxController {
  @override
  void onInit() {}
}

//TODO: Implementar GPS BLOC CON GETX