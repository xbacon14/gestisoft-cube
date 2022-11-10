import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:mobx/mobx.dart';
part 'venta_detalle.g.dart';

class VentaDetalle = VentaDetalleBase with _$VentaDetalle;

abstract class VentaDetalleBase with Store {
  int? id;
  @observable
  double? cantidad;
  @observable
  double? precio;
  Venta? venta;
  @observable
  Producto? producto;

  VentaDetalleBase(
      {this.id, this.cantidad, this.precio, this.venta, this.producto});

  VentaDetalleBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cantidad = json['cantidad'];
    precio = json['precio'].toDouble() ?? 0.0;
    venta = json['venta'] != null ? Venta.fromJson(json['venta']) : null;
    producto =
        json['producto'] != null ? Producto.fromJson(json['producto']) : null;
  }

  VentaDetalleBase.nuevo() {
    id = null;
    cantidad = 1;
    precio = 0;
    producto = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cantidad'] = cantidad;
    data['precio'] = precio;
    if (venta != null) {
      data['venta'] = venta!.toJson();
    }
    if (producto != null) {
      data['producto'] = producto!.toJson();
    }
    return data;
  }
}
