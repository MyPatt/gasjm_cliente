import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/data/models/historial_model.dart';
import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/global_widgets/circular_progress.dart';
import 'package:gasjm/app/global_widgets/text_description.dart';
import 'package:gasjm/app/global_widgets/text_subtitle.dart';
import 'package:gasjm/app/modules/historial/historial_controller.dart';
import 'package:gasjm/app/modules/historial/widgets/contenido_informacion.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//Pantalla de inicio del cliente
class HistorialPage extends StatelessWidget {
  const HistorialPage({key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    String? prevDay;
    String today = DateFormat("d MMM, y").format(DateTime.now());
    String yesterday = DateFormat("d MMM, y")
        .format(DateTime.now().add(const Duration(days: -1)));

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
                                      child:
                                          TextDescription(text: "Sin pedidos!"))
                                  : ListView.builder(
                                      itemCount:
                                          _.listaPedidosRealizados.length,
                                      itemBuilder: (context, index) {
                                        PedidoModel pedido =
                                            _.listaPedidosRealizados[index];
                                        DateTime datee = pedido
                                                .fechaHoraEntregaPedido
                                                ?.toDate() ??
                                            DateTime.now();
                                        DateTime date =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                transactions[index]
                                                    .createdMillis!
                                                    .toInt());
                                        String dateString =
                                            DateFormat("d MMM, y").format(date);

                                        if (today == dateString) {
                                          dateString = "Hoy";
                                        } else if (yesterday == dateString) {
                                          dateString = "Ayer";
                                        }

                                        bool showHeader = prevDay != dateString;
                                        prevDay = dateString;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            showHeader
                                                ? Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16,
                                                        vertical: 16),
                                                    child: Text(
                                                      //_.formatoHoraFecha(pedido .fechaHoraPedido
                                                      dateString,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2!
                                                          .copyWith(
                                                            color: AppTheme
                                                                .blueDark,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  )
                                                : const Offstage(),
                                            // buildItem(index, context, date, transaction),
                                            ContenidoInformacion(pedido,context)
                                          ],
                                        );
                                      },
                                    )),
                            )
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
      int index, BuildContext context, DateTime date, Transaction transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(width: 20),
          buildLine(index, context),
          Expanded(
            flex: 1,
            child: buildItemInfo(transaction, context),
          ),
        ],
      ),
    );
  }

  Card buildItemInfo(Transaction transaction, BuildContext context) {
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
                onTap: () {},
                /*=> Get.to(DetallePedido(
                    e: e, indiceCategoriaPedido: indiceCategoriaPedido)),*/
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextSubtitle(
                          text: 'e.nombreUsuario ??\'Cliente',
                          // style: TextoTheme.subtitleStyle2,
                        ),
                        TextSubtitle(
                          text: '11',
                          // text: 'e.cantidadPedido.toString()',
                          //  style: TextoTheme.subtitleStyle2
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                          text: transaction.name.toString(),
                        ),
                        //text: 'e.direccionUsuario ?? \'Sin ubicación'),
                        const TextDescription(text: '5 min')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextDescription(
                          text: transaction.name.toString(),
                        ),

                        // text: controladorDePedidos  .formatoFecha(e.fechaHoraPedido)),
                        const TextDescription(text: '300 m')
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
