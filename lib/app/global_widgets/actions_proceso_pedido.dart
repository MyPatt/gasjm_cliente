import 'package:flutter/material.dart';
 
//Barra de acciones cuando se a realiado un pedido  para notificar
class ActionsProcesoPedido extends StatelessWidget {
  const ActionsProcesoPedido({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        //
        onPressed: () {},
        //  onPressed: _.cargarAgenda,
        icon: const Icon(Icons.notifications_outlined));
  }
}
