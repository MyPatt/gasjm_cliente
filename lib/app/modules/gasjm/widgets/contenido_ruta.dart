import 'package:flutter/material.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:gasjm/app/modules/gasjm/widgets/form_ruta.dart';
import 'package:get/get.dart';

class ContenidoRuta extends StatelessWidget {
  ContenidoRuta({Key? key}) : super(key: key);
  final GasJMController _ = Get.put(GasJMController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          //height: Responsive.hp(context),
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*  const CircleAvatar(
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
              ),*/
              //    SizedBox(height: Responsive.getScreenSize(context).height * .05),
              Obx(() => Expanded(
                  child: ListView.builder(
                      itemCount: _.listaHorarios.length,
                      itemBuilder: (context, index) {
                        return (FormRuta(horario: _.listaHorarios[index]));
                      })))
            ],
          ),
        ),
      ],
    );
  }
}
