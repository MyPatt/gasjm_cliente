import 'package:flutter/material.dart';
import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:get/get.dart';

class GasJMController extends GetxController {
  //Repositorio de horario
  final _horarioRepository = Get.find<HorarioRepository>();

  /* Variables para obtener datos del horario*/
  final RxList<HorarioModel> _lista = <HorarioModel>[].obs;

  final horaAperturaTextController = TextEditingController();
  final horaCierreTextController = TextEditingController();
  RxList<HorarioModel> get listaHorarios => _lista;

  //
  @override
  void onInit() {
    super.onInit();
    //
    cargarDatos();
  }

  Future<void> cargarDatos() async {
//
    try {
      _lista.value = await _horarioRepository.getListaHorarios();
    } catch (e) {
      //
    }
  }
}
