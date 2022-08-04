import 'package:flutter/material.dart';
import 'package:gasjm/app.dart';
import 'package:gasjm/app/core/utils/dependency_injection.dart';
import 'package:gasjm/app/data/repository/implementations/usurio_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/data/repository/implementations/authenticacion_repository.dart';

import 'package:gasjm/app/modules/ubicacion/blocs/gps/gps_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Inyectando implentacion del repositorio de autenticacion
  Get.put<AutenticacionRepository>(AutenticacionRepositoryImpl());
  Get.put<MyUserRepository>(MyUserRepositoryImp());
//Agregar Providers y Repositories
  DependencyInjection.load();

  //Para obtener estado del GPS
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GpsBloc(),
      ),
    ],
    child: MyApp(),
  ));
}
