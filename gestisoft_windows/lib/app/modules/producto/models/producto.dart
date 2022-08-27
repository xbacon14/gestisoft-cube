import 'package:mobx/mobx.dart';
part 'producto.g.dart';

class Producto = ProductoBase with _$Producto;

abstract class ProductoBase with Store {
  int? id;
  bool? estado;
  String? nombre;
  double? cantidad;
  double? precioVenta;
  String? unidadMedida;
  String? fechaRegistro;
  double? existencia;
  String? observacion;

  ProductoBase({
    id,
    estado,
    nombre,
    cantidad,
    precioVenta,
    unidadMedida,
    fechaRegistro,
    existencia,
    observacion,
  });

  ProductoBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estado = json['estado'];
    nombre = json['nombre'];
    cantidad = json['cantidad'];
    precioVenta = json['precioVenta'];
    unidadMedida = json['unidadMedida'];
    fechaRegistro = json['fechaRegistro'];
    existencia = json['existencia'];
    observacion = json['observacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['estado'] = estado;
    data['nombre'] = nombre;
    data['cantidad'] = cantidad;
    data['precioVenta'] = precioVenta;
    data['unidadMedida'] = unidadMedida;
    data['fechaRegistro'] = fechaRegistro;
    data['existencia'] = existencia;
    data['observacion'] = observacion;
    return data;
  }

  ProductoBase.nuevo({
    this.estado = true,
    this.nombre = "",
    this.cantidad = 0,
    this.existencia = 0,
    this.precioVenta = 0,
  });

  String resolveUnidadMedida() {
    if (unidadMedida!.compareTo("METROS CÚBICOS") == 0) {
      return "M²";
    } else {
      return "UN";
    }
  }

  int resolvePrecisionUnidadMedida() {
    if (unidadMedida!.compareTo("METROS CÚBICOS") == 0) {
      return 2;
    } else {
      return 0;
    }
  }
}
