import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/horario_model.dart';

class HorarioProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //Obtener lista de los horarios de todos los dias
  Future<List<HorarioModel>> getListaHorarios() async {
    final resultado = await _firestoreInstance.collection('horario').get();

    return (resultado.docs)
        .map((item) => HorarioModel.fromJson(item.data()))
        .toList();
  }

  //Retorna los datos del horario de atencion por id eje:1 =lunes
  Future<HorarioModel> getHorarioPorIdDia({required int idDiaHorario}) async {
    final snapshot = await _firestoreInstance
        .collection("horario")
        .where("idDiaHorario", isEqualTo: idDiaHorario)
        .get();

    return HorarioModel.fromJson(snapshot.docs.first.data());
  }
}
