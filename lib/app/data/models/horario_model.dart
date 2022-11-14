class HorarioModel {
  HorarioModel({
    required this.idHorario,
    required this.idDiaHorario,
    required this.uidHorario,
    required this.aperturaHorario,
    required this.cierreHorario,
  });

  final int idHorario;
  final int idDiaHorario;
  final String uidHorario;
  final String aperturaHorario;
  final String cierreHorario;

  factory HorarioModel.fromMap(Map<String, dynamic> json) => HorarioModel(
      idHorario: json["idHorario"],
      idDiaHorario: json["idDiaHorario"],
      uidHorario: json["uidHorario"],
      aperturaHorario:json ["aperturaHorario"],
      cierreHorario:json ["cierreHorario"]);
 
}
