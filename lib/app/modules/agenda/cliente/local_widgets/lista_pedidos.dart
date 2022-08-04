import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//Muestra la lista de pedidos agendados
class ListaPedidoAgendados extends StatelessWidget {
  const ListaPedidoAgendados({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: ListTile(
                    // leading: const Icon(Icons.icecream),
                    title: Text(DateFormat.yMMMMd().format(DateTime.now())),
                    subtitle: Text(DateFormat('kk:mm').format(DateTime.now())),
                    //  trailing: Icon(Icons.food_bank),
                  ),
                ),
               ],
            );
  }
}