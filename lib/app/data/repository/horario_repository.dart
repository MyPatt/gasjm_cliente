import 'package:gasjm/app/data/models/horario_model.dart';

abstract class HorarioRepository {
  Future<HorarioModel> getHorarioPorIdDia({required int idDiaHorario});
  Future<List<HorarioModel>> getListaHorarios();
}
