import 'package:gasjm/app/data/controllers/autenticacion_controller.dart';
import 'package:get/get.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/routes/app_pages.dart';
import 'package:gasjm/app/modules/splash/splash_binding.dart';
import 'package:gasjm/app/modules/splash/splash_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gasjm/app/core/utils/dependency_injection.dart';
import 'package:gasjm/app/data/repository/implementations/usuario_repository.dart';
import 'package:gasjm/app/data/repository/usuario_repository.dart';
import 'package:gasjm/app/data/repository/authenticacion_repository.dart';
import 'package:gasjm/app/data/repository/implementations/authenticacion_repository.dart'; 
import 'package:gasjm/app/core/utils/globals.dart' as globals;
//   Add stream controller
import 'package:rxdart/rxdart.dart';

// for passing messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();

//  Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  globals.existeNotificacion.value = true;

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  //Inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Inyectando implentacion del repositorio de autenticacion

  Get.put<AutenticacionRepository>(AutenticacionRepositoryImpl());
  Get.put<MyUserRepository>(MyUserRepositoryImp());
//Agregar Providers y Repositories
  DependencyInjection.load();

  //////////////////////////////////////////////////

  //   Request permission
  final messaging = FirebaseMessaging.instance;

  // Web/iOS app users need to grant permission to receive messages
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  //  Register with FCM
  // use the registration token to send messages to users from your trusted server environment
  String? token;

  token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }

  //  Set up foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }
    _messageStreamController.sink.add(message);
  });

  //   Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//////////////////////////////////////////////////
 
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
  _MyAppState() {
    // subscribe to the message stream fed by foreground message handler
    _messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {

          globals.existeNotificacion.value = true;
        } else {
        }
      });
    });
  }

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
