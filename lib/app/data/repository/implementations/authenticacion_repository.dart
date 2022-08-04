import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:gasjm/app/data/models/usuario_model.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AutenticacionRepositoryImpl extends AutenticacionRepository {
  final _firebaseAutenticacion = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

//Modelo User de Firebase
  AutenticacionUsuario? _usuarioDeFirebase(User? usuario) => usuario == null
      ? null
      : AutenticacionUsuario(usuario.uid, usuario.displayName,usuario.tenantId);

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
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }

  @override
  Future<AutenticacionUsuario?> iniciarSesionConGoogle() async {
    final usuarioGoogle = await GoogleSignIn().signIn();
    final autenticacionGoogle = await usuarioGoogle?.authentication;

    final credencial = GoogleAuthProvider.credential(
      accessToken: autenticacionGoogle?.accessToken,
      idToken: autenticacionGoogle?.idToken,
    );

    final resultadoAutenticacion =
        await FirebaseAuth.instance.signInWithCredential(credencial);
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }

 
  @override
  Future<void> cerrarSesion() async {
    final googleSignIn = GoogleSignIn();
    await Future.delayed(const Duration(seconds: 3));
    await googleSignIn.signOut();
    await _firebaseAutenticacion.signOut();
  }

  @override
  Future<AutenticacionUsuario?> registrarUsuario(UsuarioModel usuario) async {
    //Registro de correo y contraena
    final resultadoAutenticacion =
        await _firebaseAutenticacion.createUserWithEmailAndPassword(
            email: usuario.correo, password: usuario.contrasena);
    //Actualizar Nombre y apellido del usuario creado
    await resultadoAutenticacion.user!.updateDisplayName(
      "${usuario.nombre} ${usuario.apellido}",
    );
    // //Ingresar datos de usuario
    final uid =
        Get.find<AutenticacionController>().autenticacionUsuario.value?.uid;
    firestoreInstance.collection("usuarios").doc(uid).set({
      "cedula": usuario.cedula,
      "correo": usuario.correo,
      "nombre": usuario.nombre,
      "apellido": usuario.apellido,
      "perfil": usuario.perfil,
    }).then((value) {
      print("success");
    });
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }

  @override
  Future<AutenticacionUsuario?> registrarUsuarioConGoogle(
      UsuarioModel usuario) async {
    final usuarioGoogle = await GoogleSignIn().signIn();
    final autenticacionGoogle = await usuarioGoogle?.authentication;

    final credencial = GoogleAuthProvider.credential(
      accessToken: autenticacionGoogle?.accessToken,
      idToken: autenticacionGoogle?.idToken,
    );

    final resultadoAutenticacion =
        await FirebaseAuth.instance.signInWithCredential(credencial);
    final auxUsuario = usuarioGoogle?.displayName?.split(' ') ?? [];
    // //Ingresar datos de usuario
    final uid =
        Get.find<AutenticacionController>().autenticacionUsuario.value?.uid;
    firestoreInstance.collection("usuarios").doc(uid).set({
      "cedula": usuario.cedula,
      "nombre": auxUsuario[0],
      "apellido": auxUsuario[1],
      "correo": usuarioGoogle?.email ?? '',
      "perfil": usuario.perfil,
    }).then((value) {
      print("success");
    });
    return _usuarioDeFirebase(resultadoAutenticacion.user);
  }
}
