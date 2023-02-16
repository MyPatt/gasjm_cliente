import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart'; 
import 'package:gasjm/app/global_widgets/menu_lateral.dart';
import 'package:gasjm/app/modules/notificacion/local_widgets/contenido_notificacion.dart'; 

//Pantalla   del cliente cuando su pedido se encuentra procesando
class NotificacionPage extends StatelessWidget {
  const NotificacionPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(221, 226, 227, 1),
      //Menú deslizable a la izquierda con opciones del  usuario
      drawer: const MenuLateral(),
      //Barra de herramientas de opciones para  agenda y  historial
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: AppTheme.blueBackground,
        title: const Text('Notificaciones'),
      ),
      //Body
      body: const ContenidoNotificacion(),
    );
  }
}
