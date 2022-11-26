import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/historial/historial_binding.dart';
import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:gasjm/app/modules/historial/widgets/detalle_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//Pantalla de inicio del cliente
class HistorialPage extends StatelessWidget {
  HistorialPage({key}) : super(key: key);
  final HistorialController controlador = Get.put(HistorialController());

//
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistorialController>(
      builder: (_) => Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor: AppTheme.blueBackground,
          automaticallyImplyLeading: true,
          title: const Text('Historial'),
        ),
        //Body
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => _.cargandoPedidos.value
                      ? const Center(child: CircularProgress())
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Obx(() => !_
                                        .listaPedidosRealizados.isNotEmpty
                                    ? const Center(
                                        child: TextDescription(
                                            text: "Sin pedidos!"))
                                    : buildListView(_.listaPedidosRealizados)))
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView buildListView(List<PedidoModel> lista) {
    String? prevDay;
    String today = DateFormat("d MMM, y").format(DateTime.now());
    String yesterday = DateFormat("d MMM, y")
        .format(DateTime.now().add(const Duration(days: -1)));

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        PedidoModel transaction = lista[index];
        DateTime date = DateTime.fromMillisecondsSinceEpoch(
            transaction.fechaHoraPedido.millisecondsSinceEpoch
            // controlador.listaFechas[index].millisecondsSinceEpoch
            //transactions[index].createdMillis!.toInt()
            );
        String dateString = DateFormat("d MMM, y").format(date);

        if (today == dateString) {
          dateString = "Hoy";
        } else if (yesterday == dateString) {
          dateString = "Ayer";
        }

        bool showHeader = prevDay != dateString;
        prevDay = dateString;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showHeader
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Text(
                      dateString,
                      //  '${controlador.listaFechas[index].toDate()}',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: AppTheme.blueDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
                : const Offstage(),
            buildItem(index, context, date, transaction),
          ],
        );
      },
    );
  }

  Widget buildItem(
      int index, BuildContext context, DateTime date, PedidoModel transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(width: 20),
          buildLine(index, context),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // color: Theme.of(context).accentColor,
            child: Text(
              DateFormat("HH:mm").format(date),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppTheme.light,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildItemInfo(transaction, context),
          ),
        ],
      ),
    );
  }

  Card buildItemInfo(PedidoModel pedido, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      //  shape: Border.all(color: AppTheme.light, width: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
                onTap: () =>controlador.cargarDetalle(pedido), 
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextSubtitle(
                          text: '${pedido.direccionUsuario}',
                        ),
                        TextSubtitle(
                          text: pedido.cantidadPedido > 1
                              ? '${pedido.cantidadPedido} cilindros'
                              : '${pedido.cantidadPedido} cilindro',
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                            text: pedido.estadoPedidoUsuario ?? 'Finalizado'),
                        TextDescription(text: '\$ ${pedido.totalPedido}')
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Container buildLine(int index, BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: AppTheme.blueBackground,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
                color: AppTheme.blueBackground, shape: BoxShape.circle),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: AppTheme.blueBackground,
            ),
          ),
        ],
      ),
    );
  }
}
