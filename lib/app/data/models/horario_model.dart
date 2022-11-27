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

  factory HorarioModel.fromJson(Map<String, dynamic> json) => HorarioModel(
      idHorario: json["idHorario"],
      idDiaHorario: json["idDiaHorario"],
      uidHorario: json["uidHorario"],
      aperturaHorario: json["aperturaHorario"],
      cierreHorario: json["cierreHorario"]);

  //
  static final diasSemana = [
    {
      'id': 1,
      'nombreDia': 'Lunes',
    },  {
      'id': 2,
      'nombreDia': 'Martes',
    },  {
      'id': 3,
      'nombreDia': 'Miércoles',
    },  {
      'id': 4,
      'nombreDia': 'Jueves',
    },  {
      'id': 5,
      'nombreDia': 'Viernes',
    },  {
      'id': 6,
      'nombreDia': 'Sábado',
    },  {
      'id': 7,
      'nombreDia': 'Domingo',
    }, 
  ];
}
