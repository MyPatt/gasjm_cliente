
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/horario_model.dart'; 

class HorarioProvider {
  //Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  //
 
  //Retorna los datos del horario de atencio por id eje:1 =lunes
  Future<HorarioModel> getHorarioPorIdDia({required int idDiaHorario}) async {
    final snapshot = await _firestoreInstance
        .collection("horario")
        .where("idDiaHorario", isEqualTo: idDiaHorario)
        .get();
   
      return HorarioModel.fromMap(snapshot.docs.first.data());
 
 
  }

}
