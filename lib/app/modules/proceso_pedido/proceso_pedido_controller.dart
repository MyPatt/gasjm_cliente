import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcesoPedidoController extends GetxController {
  final _personaRepository = Get.find<PersonaRepository>();
  //
  RxString imagenUsuario = ''.obs;
  @override
  void onInit() {
    //Obtiene datos del usuario que inicio sesion
    _cargarFotoPerfil();
    super.onInit();
  }

  /*METODO PARA CARGAR DATOS DE INICIO */
  Future<void> _cargarFotoPerfil() async {
    imagenUsuario.value =
        await _personaRepository.getImagenUsuarioActual() ?? '';
  }

  Future<void> cancelarPedido() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("pedido_esperando", false);
    //
    Get.offAllNamed(AppRoutes.inicio);
  }
}
