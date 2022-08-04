 

import 'package:equatable/equatable.dart';

class Producto extends Equatable {
   final String? idProducto;
    final String nombreProducto;
    final double precioProducto;
    final String descripcionProducto;
   const Producto({  this.idProducto,
        required this.nombreProducto,
        required this.precioProducto,
        required this.descripcionProducto,
    });

   
 

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        idProducto: json["idProducto"],
        nombreProducto: json["nombreProducto"],
        precioProducto: json["precioProducto"],
        descripcionProducto: json["descripcionProducto"],
    );

    Map<String, dynamic> toMap() => {
        "idProducto": idProducto,
        "nombreProducto": nombreProducto,
        "precioProducto": precioProducto,
        "descripcionProducto": descripcionProducto,
    };
    
      @override 
      List<Object?> get props => [idProducto, nombreProducto, precioProducto, descripcionProducto ];
}