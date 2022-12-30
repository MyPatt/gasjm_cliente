import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/modules/gasjm/gasjm_controller.dart';
import 'package:gasjm/app/modules/gasjm/widgets/form_horario.dart';
import 'package:get/get.dart';

class ContenidoHorario extends StatelessWidget {
  ContenidoHorario({Key? key}) : super(key: key);
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              SizedBox(
                height: 100,
                width: 100,
                child: SvgPicture.asset("assets/icons/horario.svg",
                    semanticsLabel: 'Horario'),
              ),
              SizedBox(height: Responsive.getScreenSize(context).height * .05),
              Obx(() => Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _.listaHorarios.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child:
                                FormHorario(horario: _.listaHorarios[index]));
                      })))
            ],
          ),
        ),
      ],
    );
  }
}
