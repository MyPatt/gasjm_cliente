import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/agenda/cliente/agenda_cliente_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgendaClientePage extends StatelessWidget {
  const AgendaClientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgendaClienteController>(
        builder: (_) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: AppTheme.blueBackground,
              elevation: 0.0,
              title: const Text(
                "Agenda de pedidos",
              ),

              actions: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    label: const Text("Agregar"),
                    onPressed: _.cargarEditarAgenda,
                    icon: const Icon(Icons.add_outlined))
              ],
            ),
            body: ListView(
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
            )));
  }
}
            /*
            CustomScrollView(slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    /*
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ignore: avoid_unnecessary_containers
                          Container(
                            //  margin: const EdgeInsets.symmetric(  horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(DateFormat.yMMMMd().format(DateTime.now()),
                                    style: AppTheme.subHeadingStyle),
                                const Text("Hoy", style: AppTheme.headingStyle)
                              ],
                            ),
                          ),
                          PrimaryMediumButton(texto: "+ Agendar", onPressed: (){})
                          
                           ],
                      ),
                    ),*/
                    Container(
                      alignment: Alignment.center,
                      child: const CalendarioCliente(),
                    ),
                    PrimaryMediumButton(texto: "+ Agendar", onPressed: () {}),
                    Container(color: Colors.green, height: 150.0),
                    
                  ],*/
            //  ),
            // ),
            //])
            /*Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Container(
                        //  margin: const EdgeInsets.symmetric(  horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat.yMMMMd().format(DateTime.now()),
                                style: AppTheme.subHeadingStyle),
                            const Text("Hoy", style: AppTheme.headingStyle)
                          ],
                        ),
                      ),
                      PrimaryButton(
                          texto: "+ Agendar", width: 25.0, onPressed: () {})
                    ],
                  ),
                )
              ],
            )*/
