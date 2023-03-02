import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/routes/app_pages.dart';
import 'package:gasjm/app/modules/splash/splash_binding.dart';
import 'package:gasjm/app/modules/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';  
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:gasjm/app/core/utils/dependency_injection.dart';
import 'package:gasjm/app/data/repository/implementations/usuario_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/data/repository/implementations/authenticacion_repository.dart'; 
 

Future<void> main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Inyectando implentacion del repositorio de autenticacion

  Get.put<AutenticacionRepository>(AutenticacionRepositoryImpl());
  Get.put<MyUserRepository>(MyUserRepositoryImp());
//Agregar Providers y Repositories
  DependencyInjection.load();

 
 
  //Para obtener estado del GPS
  runApp(  const MyApp(),
   );
}
//

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //controlador de autenticacion
  final autenticacionController = Get.put(AutenticacionController());
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AutenticacionController>(
        init: autenticacionController,
        builder: (_) {
          return GetMaterialApp(
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            supportedLocales: const [Locale('en'), Locale('es')],
            debugShowCheckedModeBanner: false,
            title: 'Gas J&M',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: AppTheme.blueBackground)),
            home: const SplashPage(),
            initialBinding: SplashBinding(),
            getPages: AppPages.pages,
          );
        });
  }
}
