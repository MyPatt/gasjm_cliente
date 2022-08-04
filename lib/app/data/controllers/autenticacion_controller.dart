//Estados de sutenticacion
import 'dart:async'; 
import 'package:gasjm/app/data/repository/authenticacion_repository.dart'; 
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';

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
    await Future.delayed(const Duration(seconds: 3));
    //Testea la suscripcion del cambio de estado de inicio sesion para ir a la pagina de introduccion u login
    _autenticacionSuscripcion = _autenticacionRepository
        .enEstadDeAutenticacionCambiado
        .listen(_estadoAutenticacionCambiado);

    super.onInit();
  }

  void _estadoAutenticacionCambiado(AutenticacionUsuario? usuario) {
    if (usuario == null) {
      autenticacionEstado.value = EstadosDeAutenticacion.sesionNoIniciada;

      Get.offAllNamed(AppRoutes.ubicacion);
    } else {
      autenticacionEstado.value = EstadosDeAutenticacion.sesionIniciada;
      
      Get.offAllNamed(AppRoutes.inicio);
 
    }
    autenticacionUsuario.value = usuario;
  }

  Future<void> cerrarSesion() async {
    await _autenticacionRepository.cerrarSesion();
  }

  @override
  void onClose() {
    _autenticacionSuscripcion.cancel();
    super.onClose();
  }
}
