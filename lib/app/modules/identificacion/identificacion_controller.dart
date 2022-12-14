import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class IdentificacionController extends GetxController {
  final _userRepository = Get.find<PersonaRepository>();
  //

  //Controller para texto de la cedula
  final cedulaTextoController = TextEditingController();
  //
  final cargando = RxBool(false);
  final formKey = GlobalKey<FormState>();

//Guardar cedula de forma local
  Future<void> _guardarCedula() async {
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("cedula_usuario", cedulaTextoController.text);
    //
    String? cedula = prefs.getString("cedula_usuario");

    if (cedula == null) {
      await prefs.setString("cedula_usuario", cedulaTextoController.text);
    }
    //
  }

  //Guardar correo de forma local
  Future<void> _guardarCorreo() async {
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final correo = await _userRepository.getDatoPersonaPorField(
        field: "cedula", dato: cedulaTextoController.text, getField: "correo");
    await prefs.setString("correo_usuario", correo.toString());
    //
    String? _correo = prefs.getString("correo_usuario");

    if (_correo == null) {
      final correo = await _userRepository.getDatoPersonaPorField(
          field: "cedula",
          dato: cedulaTextoController.text,
          getField: "correo");
      await prefs.setString("correo_usuario", correo.toString());
    }
    //
    print("````````````````$correo````````````````");
  }

//Buscar si tiene cuenta o no
  /*Future<void> ggetUsuarioPorCedula() async {
    usuario.value =
        await _userRepository.getPersonaPorCedula(cedula: cedulaTextoController.text);
  }
*/
//
  cargarRegistroOLogin() async {
    final String? dato;

    try {
      cargando.value = true;
      await Future.delayed(const Duration(seconds: 1));

      dato = await _userRepository.getDatoPersonaPorField(
          field: "cedula",
          dato: cedulaTextoController.text,
          getField: "idPerfil");

      if (dato == null) {
        _guardarCedula();
        Get.offNamed(AppRoutes.registrar);
      } else {
        //Cedula ya registrada ir a la pagina de inicio de sesion
        if (dato.toLowerCase() == "cliente") {
          Future.wait([_guardarCorreo(), _guardarCedula()]);

          await Future.delayed(const Duration(seconds: 1));
          Mensajes.showGetSnackbar(
              titulo: 'Informaci??n',
              mensaje:
                  'C??dula ya registrada, ingrese su contrase??a para iniciar sesi??n.',
              duracion: const Duration(seconds: 7),
              icono: const Icon(
                Icons.info_outlined,
                color: Colors.white,
              ));
          await Future.delayed(const Duration(seconds: 1));

          Get.offNamed(AppRoutes.login);
        } else {
          Mensajes.showGetSnackbar(
              titulo: 'Alerta',
              mensaje:
                  'C??dula ya registrada como ${dato.toLowerCase()}, instale la aplicaci??n  o ingrese una c??dula diferente para  iniciar sesi??n.',
              duracion: const Duration(seconds: 7),
              icono: const Icon(
                Icons.error_outline_outlined,
                color: Colors.white,
              ));
        }
      }
    } catch (e) {
      Mensajes.showGetSnackbar(
          titulo: 'Alerta',
          mensaje:
              'Ha ocurrido un error, por favor int??ntelo de nuevo m??s tarde.',
          duracion: const Duration(seconds: 4),
          icono: const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ));
    }
    cargando.value = false;
  }

  @override
  void onClose() {
    cedulaTextoController.dispose();
  }
}
