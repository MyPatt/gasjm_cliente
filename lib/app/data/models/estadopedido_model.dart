
class EstadoPedidoModel {
    EstadoPedidoModel({
        required this.idEstadoPedido,
        required this.nombreEstadoPedido,
        required this.descripcionEstadoPedido,
    });

    final String idEstadoPedido;
    final String nombreEstadoPedido;
    final String descripcionEstadoPedido;

    factory EstadoPedidoModel.fromMap(Map<String, dynamic> json) => EstadoPedidoModel(
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