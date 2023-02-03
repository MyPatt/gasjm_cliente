import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';
import 'package:gasjm/app/routes/app_routes.dart'; 
import 'package:get/get.dart';

class IdentificacionController extends GetxController {
  final _userRepository = Get.find<PersonaRepository>();
  //

  //Controller para texto de la cedula
  final cedulaTextoController = TextEditingController();
  //
  final cargando = RxBool(false);
  final formKey = GlobalKey<FormState>();

 



//Buscar si tiene cuenta o no
  /*Future<void> ggetUsuarioPorCedula() async {
    usuario.value =
        await _userRepository.getPersonaPorCedula(cedula: cedulaTextoController.text);
  }
*/
//
  Future<void> cargarRegistroOLogin() async {
    try {
      cargando.value = true;

              //Obtener cedula para el registro
        String _cedula=cedulaTextoController.text;
      await Future.delayed(const Duration(seconds: 1));

      //Obtener idPerfil si existe un usuario con la cedula ingresada
      final String? obtenerIdPerfil =
          await _userRepository.getDatoPersonaPorField(
              field: "cedula",
              dato: cedulaTextoController.text,
              getField: "idPerfil");

      //Verificar si se obtuvo el idPerfil, si es null aun no existe el usuario
      if (obtenerIdPerfil == null) {

     
        Get.toNamed(AppRoutes.registrar,arguments: _cedula);
      } else {
        //Cedula ya registrada ir a la pagina de inicio de sesion
        if (obtenerIdPerfil.toLowerCase() == "cliente") {
    
          Mensajes.showGetSnackbar(
              titulo: 'Información',
              mensaje:
                  'Cédula ya registrada, ingrese su contraseña para iniciar sesión.',
              duracion: const Duration(seconds: 6),
              icono: const Icon(
                Icons.info_outlined,
                color: Colors.white,
              ));
   

          Get.toNamed(AppRoutes.login, arguments: _cedula);
        } else {
          Mensajes.showGetSnackbar(
              titulo: 'Alerta',
              mensaje:
                  'Cédula ya registrada como ${obtenerIdPerfil.toLowerCase()}, instale la aplicación  o ingrese una cédula diferente para  iniciar sesión.',
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
              'Ha ocurrido un error, por favor inténtelo de nuevo más tarde.',
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
