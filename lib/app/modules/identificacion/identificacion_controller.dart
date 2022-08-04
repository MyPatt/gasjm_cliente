import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class IdentificacionController extends GetxController {
  final _userRepository = Get.find<MyUserRepository>();
  //
  Rx<UsuarioModel?> usuario = Rx(null);
  //Controller para texto de la cedula
  final cedulaTextoController = TextEditingController();
  //
  final cargando = RxBool(false);
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

//Guardar cedula de forma local
  _guardarCedula() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("cedula_usuario", cedulaTextoController.text);
  }

  //
  _guardarCorreo(String correo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("correo_usuario", correo);
  }

//Buscar si tiene cuenta o no
  Future<void> getUsuarioPorCedula() async {
    usuario.value =
        await _userRepository.getUsuarioPorCedula(cedulaTextoController.text);
  }

//
  cargarPerfil() async {
    final s;

    try {
      cargando.value = true;
      await Future.delayed(const Duration(seconds: 1));
//
      usuario.value =
          await _userRepository.getUsuarioPorCedula(cedulaTextoController.text);
      s = usuario.value?.cedula!.isEmpty;

      if (s == null) {
        _guardarCedula();
        Get.offNamed(AppRoutes.registrar);
      } else {
        _guardarCorreo(usuario.value!.correo);

        Get.snackbar(
          'Mensaje',
          'Existe una cuenta con la cédula ingresada. Para registrar una nueva cuenta ingrese una cédula diferente.',
          duration: const Duration(seconds: 4),
          backgroundColor: AppTheme.blueDark,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 0
        );

        Get.offNamed(AppRoutes.login);
      }

      //

    } catch (e) {
      // print(e);
    }
    cargando.value = false;
  }
}
