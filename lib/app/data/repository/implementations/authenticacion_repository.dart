import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/data/models/persona_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacionRepositoryImpl extends AutenticacionRepository {
  final _firebaseAutenticacion = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  //Get uid del usuario ingresado

//Modelo User de Firebase
  AutenticacionUsuario? _usuarioDeFirebase(User? usuario) => usuario == null
      ? null
      : AutenticacionUsuario(
          usuario.uid, usuario.displayName, usuario.tenantId);

  @override
  AutenticacionUsuario? get autenticacionUsuario =>
      _usuarioDeFirebase(_firebaseAutenticacion.currentUser);

  @override
  Stream<AutenticacionUsuario?> get enEstadDeAutenticacionCambiado =>
      _firebaseAutenticacion.authStateChanges().asyncMap(_usuarioDeFirebase);

  @override
  Future<AutenticacionUsuario?> crearUsuarioConCorreoYContrasena(
      String correo, String contrasena) async {
    //Registro de correo y contraena
    final resultadoAutenticacion = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: correo, password: contrasena);
    //Actualizar Nombre y apellido

    //
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }

  @override
  Future<AutenticacionUsuario?> iniciarSesionConCorreoYContrasena(
      String correo, String contrasena) async {
    final resultadoAutenticacion = await _firebaseAutenticacion
        .signInWithEmailAndPassword(email: correo, password: contrasena);
    //
    await _agregarTokenParaFCM();
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }

  @override
  Future<void> cerrarSesion() async {
    await Future.delayed(const Duration(seconds: 2));
  //Borrar token
    await _borrarTokenParaFCM();
    await _firebaseAutenticacion.signOut();
    //Limpiar memoria de datos guardados de forma local
    await _borrarDatosGuardados();

  
  }

  @override
  Future<AutenticacionUsuario?> registrarUsuario(PersonaModel usuario) async {
    //
    final resultadoAutenticacion =
        await _crearUsuarioConCorreoYContrasena(usuario);

    //
    //Ingresar datos de usuario en firestore
    await _insertPersona(usuario);
    //Guardar token _
    await _agregarTokenParaFCM();
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }

  //
  Future<UserCredential> _crearUsuarioConCorreoYContrasena(
      PersonaModel usuario) async {
    //Registro de correo y contraena
    final resultadoAutenticacion =
        await _firebaseAutenticacion.createUserWithEmailAndPassword(
            email: usuario.correoPersona ?? '',
            password: usuario.contrasenaPersona);

    //Actualizar Nombre y apellido del usuario creado
    await resultadoAutenticacion.user!.updateDisplayName(
      "${usuario.nombrePersona} ${usuario.apellidoPersona}",
    );
    //
    return resultadoAutenticacion;
  }

  //
  Future<void> _insertPersona(PersonaModel usuario) async {
    final uid =
        Get.find<AutenticacionController>().autenticacionUsuario.value!.uid;
    await firestoreInstance.collection("persona").doc(uid).set(usuario.toMap());
    //Actualizar uid del usuario ingresado
    firestoreInstance.collection("persona").doc(uid).update({"uid": uid});
  }

  //
  Future<void> _agregarTokenParaFCM() async {
    var messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    final uid =
        Get.find<AutenticacionController>().autenticacionUsuario.value!.uid;
    //
    await firestoreInstance.collection("persona").doc(uid).update({
      "tokensParaNotificacion": FieldValue.arrayUnion([token]),
    });
  }

  //
  Future<void> _borrarTokenParaFCM() async {
    var messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    final uid =
        Get.find<AutenticacionController>().autenticacionUsuario.value!.uid;
    //
    await firestoreInstance.collection("persona").doc(uid).update({
      "tokensParaNotificacion": FieldValue.arrayRemove([token]),
    });
  }

  Future<void> _borrarDatosGuardados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("cedula_usuario");
    await prefs.clear();
  }
}
