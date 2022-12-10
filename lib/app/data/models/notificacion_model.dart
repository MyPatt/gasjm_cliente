class Notificacion {
  Notificacion({
     this.idNotificacion,
    required this.fechaNotificacion,
    required this.tituloNotificacion,
    required this.textoNotificacion,
    required this.idEmisorNotificacion,
    required this.idRemitenteNotificacion,
  });

  final String? idNotificacion;
  final String fechaNotificacion;
  final String tituloNotificacion;
  final String textoNotificacion;
  final String idEmisorNotificacion;
  final String idRemitenteNotificacion;

  factory Notificacion.fromMap(Map<String, dynamic> json) => Notificacion(
        idNotificacion: json["idNotificacion"],
        fechaNotificacion: json["fechaNotificacion"],
        tituloNotificacion: json["tituloNotificacion"],
        textoNotificacion: json["textoNotificacion"],
        idEmisorNotificacion: json["idEmisorNotificacion"],
        idRemitenteNotificacion: json["idRemitenteNotificacion"],
      );

  Map<String, dynamic> toMap() => {
        "idNotificacion": idNotificacion,
        "fechaNotificacion": fechaNotificacion,
        "tituloNotificacion": tituloNotificacion,
        "textoNotificacion": textoNotificacion,
        "idEmisorNotificacion": idEmisorNotificacion,
        "idRemitenteNotificacion": idRemitenteNotificacion,
      };
}
