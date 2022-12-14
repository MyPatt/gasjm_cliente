import 'package:cloud_firestore/cloud_firestore.dart';

class EstadoPedidoModel {
  EstadoPedidoModel({
    required this.idEstadoPedido,
    required this.nombreEstadoPedido,
    required this.descripcionEstadoPedido,
  });

  final String idEstadoPedido;
  final String nombreEstadoPedido;
  final String descripcionEstadoPedido;

  factory EstadoPedidoModel.fromMap(Map<String, dynamic> json) =>
      EstadoPedidoModel(
        idEstadoPedido: json["idEstadoPedido"],
        nombreEstadoPedido: json["nombreEstadoPedido"],
        descripcionEstadoPedido: json["descripcionEstadoPedido"],
      );

  Map<String, dynamic> toMap() => {
        "idEstadoPedido": idEstadoPedido,
        "nombreEstadoPedido": nombreEstadoPedido,
        "descripcionEstadoPedido": descripcionEstadoPedido,
      };
}

//Clases con atributos del estado id, fechaHora, idPersona quien a cambiado el estado puede ser el cliente, repartidor o el admin
class EstadoDelPedido {
  EstadoDelPedido({
    required this.idEstado,
    required this.fechaHoraEstado,
    required this.idPersona,
  });

  final String idEstado;
  final Timestamp fechaHoraEstado;
  final String idPersona;
  String? nombreEstado;
  String? nombreUsuario;

  factory EstadoDelPedido.fromJson(Map<String, dynamic> json) =>
      EstadoDelPedido(
          idEstado: json["idEstado"],
          fechaHoraEstado: json["fechaHoraEstado"],
          idPersona: json["idPersona"]);
  Map<String, dynamic> toMap() => {
        "idEstado": idEstado,
        "fechaHoraEstado": fechaHoraEstado,
        "idPersona": idPersona
      };
}
