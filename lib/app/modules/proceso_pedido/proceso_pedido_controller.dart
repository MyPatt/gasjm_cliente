 

import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:get/get.dart';

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

}
