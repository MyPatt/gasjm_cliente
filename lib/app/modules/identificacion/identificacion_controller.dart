import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class IdentificacionController extends GetxController {
  final _userRepository = Get.find<PersonaRepository>();
  //
  Rx<PersonaModel?> usuario = Rx(null);
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
  /*Future<void> ggetUsuarioPorCedula() async {
    usuario.value =
        await _userRepository.getPersonaPorCedula(cedula: cedulaTextoController.text);
  }
*/
//
  cargarPerfil() async {
    final cedula;

    try {
      cargando.value = true;
      await Future.delayed(const Duration(seconds: 1));
//
      print("oobject");
      usuario.value = await _userRepository.getPersonaPorCedula(
          cedula: cedulaTextoController.text);
      cedula = usuario.value?.cedulaPersona.isEmpty;

      if (cedula == null) {
        //En caso de no encontrar el numero de cedula, continuar a la pagina de registro
        _guardarCedula();

        Get.offNamed(AppRoutes.registrar);
      } else {
        //Cedula ya registrada ir a la pagina de inicio de sesion
        if (usuario.value?.idPerfil.toLowerCase() == "cliente") {
          _guardarCorreo(usuario.value?.correoPersona ?? cedula);

          Mensajes.showGetSnackbar(
              titulo: 'Información',
              mensaje:
                  'Cédula ya registrada, ingrese su contraseña para iniciar sesión o cree una nueva cuenta  con una cédula diferente.',
              duracion: const Duration(seconds: 7),
              icono: const Icon(
                Icons.info_outlined,
                color: Colors.white,
              ));

          Get.offNamed(AppRoutes.login);
        } else {
          Mensajes.showGetSnackbar(
              titulo: 'Alerta',
              mensaje:
                  'Cédula ya registrada como repartidor, instale la aplicación  o ingrese una cédula diferente para  iniciar sesión.',
              duracion: const Duration(seconds: 7),
              icono: const Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
              ));
        }
      }
    } on FirebaseException catch (e) {
      print(">>> ${e.message}");
    }
    cargando.value = false;
  }
}
