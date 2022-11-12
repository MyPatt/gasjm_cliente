import 'package:flutter/material.dart';
import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/routes/app_pages.dart';
import 'package:gasjm/app/modules/splash/splash_binding.dart';
import 'package:gasjm/app/modules/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
//controlador de autenticacion
  final autenticacionController = Get.put(AutenticacionController());
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
