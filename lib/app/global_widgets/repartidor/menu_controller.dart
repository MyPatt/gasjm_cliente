import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  @override
  void onInit() {
    _cargarDatosIniciales();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  /* DATOS DEL USUARIO */
  /* Variables para obtener datos del usuario */
  //Repositorio de usuario
  final _userRepository = Get.find<MyUserRepository>();
  //
  Rx<UsuarioModel?> usuario = Rx(null);
  Future<void> _getUsuarioActual() async {
    usuario.value = await _userRepository.getUsuario();
  }

  void _cargarDatosIniciales() {
    _getUsuarioActual();
  }
}
