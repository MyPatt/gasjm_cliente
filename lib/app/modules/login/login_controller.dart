import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/core/utils/mensajes.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/data/repository/persona_repository.dart';

import 'package:get/get.dart'; 

class LoginController extends GetxController {
  ///

  final RxBool _contrasenaOculta = true.obs;
  RxBool get contrasenaOculta => _contrasenaOculta;

  //Variables para el form
  final formKey = GlobalKey<FormState>();

  final correoTextoController = TextEditingController();
  final contrasenaTextoController = TextEditingController();

  bool estadoProceso = false;

//
  @override
  void onInit() {
    Future.wait([obtenerCorreo()]);

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    //
    correoTextoController.clear();
    contrasenaTextoController.clear();
    correoTextoController.dispose();
    contrasenaTextoController.dispose();
  }

  void mostrarContrasena() {
    _contrasenaOculta.value = _contrasenaOculta.value ? false : true;
  }

  //** Autenticacion para iniciar sesion **
  //Dependencia de AutenticacionRepository
  final _autenticacioRepository = Get.find<AutenticacionRepository>();

//Inicar sesion con correo

  //Existe algun error si o no
  final errorParaCorreo = Rx<String?>(null);
  //Se cargo si o no
  final cargandoParaCorreo = RxBool(false);

  Future<void> iniciarSesionConCorreoYContrasena() async {
    try {
      cargandoParaCorreo.value = true;

      errorParaCorreo.value = null;
      //Testear
      await Future.delayed(const Duration(seconds: 1));
      //
      await _autenticacioRepository.iniciarSesionConCorreoYContrasena(
        correoTextoController.text,
        contrasenaTextoController.value.text,
      );

      //Mensaje de bienvenida
      Mensajes.showGetSnackbar(
          titulo: 'Mensaje',
          mensaje: '¡Bienvenido a GasJM!',
          icono: const Icon(
            Icons.waving_hand_outlined,
            color: Colors.white,
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorParaCorreo.value =
            'Ningún usuario encontrado con ese correo electrónico.';
      } else if (e.code == 'wrong-password') {
        errorParaCorreo.value = 'Contraseña incorrecta.';
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
    cargandoParaCorreo.value = false;
  }

  //Obtener correo
  Future<void> obtenerCorreo() async {
    final String cedula = Get.arguments;
    final correo = await Get.find<PersonaRepository>().getDatoPersonaPorField(
        field: "cedula", dato: cedula, getField: "correo");
    //
    correoTextoController.text = correo ?? '';
  }
}
