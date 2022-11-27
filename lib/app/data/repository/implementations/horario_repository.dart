import 'package:gasjm/app/data/models/horario_model.dart';
import 'package:gasjm/app/data/providers/horario_provider.dart';
import 'package:gasjm/app/data/repository/horario_repository.dart';
import 'package:get/get.dart';

class HorarioRepositoryImpl extends HorarioRepository {
  final _provider = Get.find<HorarioProvider>();

  @override
  Future<HorarioModel> getHorarioPorIdDia({required int idDiaHorario}) =>
      _provider.getHorarioPorIdDia(idDiaHorario: idDiaHorario);

  @override
  Future<List<HorarioModel>> getListaHorarios() => _provider.getListaHorarios();
}
