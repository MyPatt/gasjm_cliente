import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gasjm/app/data/models/estadopedido_model.dart';

class PedidoModel {
  final String? idPedido;
  final String idProducto;
  final String idCliente;
  final String idRepartidor;
  final Direccion direccion;
  final String idEstadoPedido;
  final Timestamp fechaHoraPedido;
  final String diaEntregaPedido;
  final Timestamp? fechaHoraEntregaPedido;
  String? nombreUsuario;
  String? direccionUsuario;
  String? estadoPedidoUsuario;
  int? tiempoEntrega;
  //
  final EstadoDelPedido? estadoPedido1;
  //Para guardar los datos cuando el pedido esta en camino (info de quien esta camino a entregar el pedido)

  final EstadoDelPedido? estadoPedido2;
  //Para guardar los datos cuando el pedido se a finalizado (info de quien cancela o finaliza el pedido)

  final EstadoDelPedido? estadoPedido3;

  final int cantidadPedido;
  final String? notaPedido;
  final double totalPedido;
  //
  PedidoModel({
    this.idPedido,
    required this.idProducto,
    required this.idCliente,
    required this.idRepartidor,
    required this.direccion,
    required this.idEstadoPedido,
    required this.fechaHoraPedido,
    required this.diaEntregaPedido,
    this.fechaHoraEntregaPedido,
    required this.cantidadPedido,
    required this.notaPedido,
    required this.totalPedido,
    //
    this.estadoPedido1,
    this.estadoPedido2,
    this.estadoPedido3,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) => PedidoModel(
        idPedido: json["idPedido"],
        idProducto: json["idProducto"],
        idCliente: json["idCliente"],
        idRepartidor: json["idRepartidor"],
        idEstadoPedido: json["idEstadoPedido"],
        fechaHoraPedido: json["fechaHoraPedido"],
        fechaHoraEntregaPedido: json["fechaHoraEntregaPedido"],
        diaEntregaPedido: json["diaEntregaPedido"],
        notaPedido: json["notaPedido"],
        totalPedido: json["totalPedido"],
        direccion: Direccion.fromMap(json["direccion"]),
        cantidadPedido: json["cantidadPedido"],
      );

  Map<String, dynamic> toJson() => {
        "idPedido": idPedido,
        "idProducto": idProducto,
        "idCliente": idCliente,
        "idRepartidor": idRepartidor,
        "idEstadoPedido": idEstadoPedido,
        "fechaHoraPedido": fechaHoraPedido,
        "fechaHoraEntregaPedido": fechaHoraEntregaPedido,
        "diaEntregaPedido": diaEntregaPedido,
        "notaPedido": notaPedido,
        "totalPedido": totalPedido,
        "direccion": direccion.toMap(),
        "estadoPedido1": null,
        "estadoPedido2": null,
        "estadoPedido3": null,
        "cantidadPedido": cantidadPedido,
      };
}

class Direccion {
  Direccion({
    required this.latitud,
    required this.longitud,
  });

  final double latitud;
  final double longitud;

  factory Direccion.fromMap(Map<String, dynamic> json) => Direccion(
        latitud: json["latitud"],
        longitud: json["longitud"],
      );

  Map<String, dynamic> toMap() => {
        "latitud": latitud,
        "longitud": longitud,
      };
}
