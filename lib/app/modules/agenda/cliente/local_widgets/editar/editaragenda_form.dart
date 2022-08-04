import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:gasjm/app/core/utils/responsive.dart';
import 'package:gasjm/app/global_widgets/input_text.dart';
import 'package:gasjm/app/global_widgets/primary_button.dart';
import 'package:gasjm/app/modules/agenda/cliente/local_widgets/editar/editar_controller.dart';
import 'package:get/get.dart';

class EditarAgendaForm extends StatelessWidget {
  const EditarAgendaForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditarAgendaController>(
        builder: (_) => Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                height: Responsive.getScreenSize(context).height * .60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: <Widget>[
                      /*  Text(
                        "Agendar un pedido",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: AppTheme.blue, fontWeight: FontWeight.w900),
                      ),*/
                      Text(
                        "Ingrese los datos para agendar un nuevo pedido",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: Colors.black38, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .05),
                      InputText(
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.maps_home_work_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                    
                        labelText: "Barrio / Sector",
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.room_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none, 
                        labelText: "Calle principal",
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.map_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none, 
                        labelText: "Calle secundaria",
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        keyboardType: TextInputType.streetAddress,
                        iconPrefix: Icons.home_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none, 
                        labelText: "Referencia",
                        filled: false,
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      Obx(() {
                        return InputText(
                          iconPrefix: Icons.calendar_today_outlined,
                          iconColor: AppTheme.light,
                          border: InputBorder.none,
                          keyboardType: TextInputType.datetime,
                          // obscureText: _.isOscure.value,
                          maxLines: 1,
                          //validator: null,
                          controller: _.myController.value,
                          labelText: "Fecha",
                          filled: false,
                          onTap: () {
                            _.selectDate(context);
                          },
                          onChanged: (text) {
                            print("First text field: $text");
                          },
                        );
                      }),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        iconPrefix: Icons.timer_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        keyboardType: TextInputType.datetime,
                        // obscureText: _.isOscure.value,
                        maxLines: 1,
                        //validator: null,
                        labelText: "Hora",
                        filled: false,

                        //  onChanged: _.onChangedContrasenaUsuario, pim mapa room
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .02),
                      InputText(
                        iconPrefix: Icons.pin_outlined,
                        iconColor: AppTheme.light,
                        border: InputBorder.none,
                        keyboardType: TextInputType.number,
                        //validator: null,
                        labelText: "Cantidad",
                        initialValue: "1",
                        filled: false,

                        //   onChanged: _.onChangedNombreUsuario
                      ),
                      SizedBox(
                          height:
                              Responsive.getScreenSize(context).height * .05),
                      PrimaryButton(
                        texto: "Agendar",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
