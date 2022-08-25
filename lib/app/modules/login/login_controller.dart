import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; 
import 'package:gasjm/app/core/utils/mensajes.dart'; 
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';

import 'package:get/get.dart';
 
import 'package:shared_preferences/shared_preferences.dart';

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
    _obtenerCorreo();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    //
    _removerCorreo();
    super.onClose();
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
      await _autenticacioRepository.iniciarSesionConCorreoYContrasena(
        correoTextoController.text,
        contrasenaTextoController.value.text,
      );
      
      //
      Mensajes.showGetSnackbar(titulo: 'Mensaje', mensaje: '¡Bienvenido a GasJM!',icono: const Icon(Icons.waving_hand_outlined,color: Colors.white,)); 
 
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorParaCorreo.value =
            'Ningún usuario encontrado con ese correo electrónico.';
      } else if (e.code == 'wrong-password') {
        errorParaCorreo.value = 'Contraseña incorrecta.';
      }
    } catch (e) {
      errorParaCorreo.value = 'Error de inicio de sesión. Inténtalo de nuevo.';
    }
    cargandoParaCorreo.value = false;
  }

  //Obtener correo de forma local
  _obtenerCorreo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final s = prefs.getString("correo_usuario");
    correoTextoController.text = s ?? '';
  }

  //Remover correo de forma local
  _removerCorreo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("correo_usuario");
  }
}
