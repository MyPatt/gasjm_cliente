import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:gasjm/app/modules/gasjm/widgets/contenido_horario.dart';
import 'package:gasjm/app/modules/gasjm/widgets/contenido_ruta.dart';
import 'package:get/get.dart';

class GasJMPage extends StatelessWidget {
  const GasJMPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GasJMController>(
        builder: (_) => Scaffold(
              backgroundColor: AppTheme.background,

              //
              appBar: AppBar(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                backgroundColor: AppTheme.blueBackground,
                automaticallyImplyLeading: true,
                title: const Text("Gas J&M"),
              ),
              body: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: const TabBar(
                        indicatorColor: AppTheme.blueBackground,
                        labelColor: AppTheme.blueBackground,
                        unselectedLabelColor: AppTheme.light,
                        // El repartidor vera todos los pedidos en espera, en camabio  aceptados y finalizados solo por el
                        tabs: [
                          Tab(text: 'Horarios'),
                          Tab(text: 'Rutas'),
                        ],
                      ),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      //se envia el modo para cargar la lista de los pedidos el administrador carga de todos
                      //y el repartidor solo los correspondientes y al actualizar se cargan de nuevo la lista
                      //refactorizado el codigo actualizar para usar por el administrador y repartidor
                      // 0 administrador
                      // 1 repartidor
                      /*  ContenidoPedido(
                      indiceCategoriaPedido: 0,
                      modo: 1,
                    ),*/
                      ContenidoHorario(),
                      ContenidoRuta()
                    ]))
                  ],
                ),
              ),
            ));
  }
}
