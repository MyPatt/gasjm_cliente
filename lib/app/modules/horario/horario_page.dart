import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';

import 'package:gasjm/app/modules/horario/horario_controller.dart';
import 'package:gasjm/app/modules/horario/local_widgets/form_horario.dart';
import 'package:get/get.dart';

class HorarioPage extends StatelessWidget {
  const HorarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var cryptoData = CryptoData.getData;
    return GetBuilder<HorarioController>(
        builder: (_) => Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              automaticallyImplyLeading: true,
              backgroundColor: AppTheme.blueBackground,
              elevation: 0.0,
              title: const Text(
                "Horario de atención",
              ),
            ),
            body: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 25),
                    child: SizedBox(
                        height: Responsive.hp(context) * 0.83,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            height: 350,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            // height: Responsive.hp(context),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                      height: Responsive.getScreenSize(context)
                                              .height *
                                          .05),
                                  const CircleAvatar(
                                    backgroundColor: AppTheme.light,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.backup_table_rounded,
                                        color: AppTheme.blueDark,
                                        size: 50,
                                      ),
                                      radius: 55.0,
                                    ),
                                    radius: 56.0,
                                  ),
                                  SizedBox(
                                      height: Responsive.getScreenSize(context)
                                              .height *
                                          .05),
                                  Obx(() => Expanded(
                                      child: ListView.builder(
                                          // scrollDirection: Axis.horizontal,
                                          itemCount: _.listaHorarios.length,
                                          itemBuilder: (context, index) {
                                            return FormHorario(
                                                horario:
                                                    _.listaHorarios[index]);
                                          })))
                                ])))))));
  }
}
