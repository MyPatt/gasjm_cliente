import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditarAgendaController extends GetxController {
  RxString fecha = DateFormat.yMMMMd().format(DateTime.now()).obs;
  late DateTime hora;
  //
  final myController = TextEditingController().obs;
  @override
  void onInit() {
    super.onInit();
    //
    //fecha.value = DateFormat.yMMMMd().format(DateTime.now());
    hora = DateTime.now();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    myController.value.dispose();
    super.onClose();
  }

  mostrarCalendario(BuildContext context) {}
  //Fecha
  Future<void> selectDate(BuildContext context) async {
    print(fecha.value);
    final DateTime? d = await showDatePicker(
      //we wait for the dialog to return
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2023),
      initialEntryMode: DatePickerEntryMode.calendarOnly
    );
    if (d != null) //if the user has selected a date
    {
      // we format the selected date and assign it to the state variable
      fecha.value = DateFormat.yMMMMd("en_US").format(d);
      print(fecha.value);
    }
    myController.value = TextEditingController(text: fecha.value);
  }

  _printLatestValue() {
    print("Second text field: ${myController.value.text}");
  }
}
