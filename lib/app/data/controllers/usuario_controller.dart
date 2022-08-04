import 'dart:async';

import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:get/get.dart';

class MyUserController extends GetxController {
  final _userRepository = Get.find<MyUserRepository>();

  Rx<UsuarioModel?> usuario = Rx(null);

  @override
  void onInit() {
    getMyUser();
    super.onInit();
  }

  Future<void> getMyUser() async {
    usuario.value = await _userRepository.getUsuario();
  }
}
