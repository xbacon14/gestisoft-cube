import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta_detalle.dart';
import 'package:mobx/mobx.dart';
part 'venta.g.dart';

class Venta = VentaBase with _$Venta;

abstract class VentaBase with Store {
  @observable
  int? id;
  String? chofer;
  String? docNro;
  String? fecha;
  String? observacion;
  double? total;
  String? vehiculo;
  bool? estado;
  @observable
  Vendedor? vendedor;
  @observable
  Cliente? cliente;
  ObservableList<VentaDetalle>? detalles;

  VentaBase(
      {this.id,
      this.chofer,
      this.docNro,
      this.fecha,
      this.observacion,
      this.total,
      this.vehiculo,
      this.estado,
      this.vendedor,
      this.cliente,
      this.detalles});

  VentaBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chofer = json['chofer'];
    docNro = json['docNro'];
    fecha = json['fecha'];
    observacion = json['observacion'];
    total = json['total'];
    vehiculo = json['vehiculo'];
    estado = json['estado'];
    vendedor =
        json['vendedor'] != null ? Vendedor.fromJson(json['vendedor']) : null;
    cliente =
        json['cliente'] != null ? Cliente.fromJson(json['cliente']) : null;
    if (json['detalles'] != null) {
      detalles = ObservableList<VentaDetalle>();
      json['detalles'].forEach((v) {
        detalles!.add(VentaDetalle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chofer'] = chofer;
    data['docNro'] = docNro;
    data['fecha'] = fecha;
    data['observacion'] = observacion;
    data['total'] = total;
    data['vehiculo'] = vehiculo;
    data['estado'] = estado;
    if (vendedor != null) {
      data['vendedor'] = vendedor!.toJson();
    }
    if (cliente != null) {
      data['cliente'] = cliente!.toJson();
    }
    if (detalles != null) {
      data['detalles'] = detalles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Venta nuevo() {
    return Venta(
      id: null,
      chofer: "",
      estado: true,
      cliente: Cliente().nuevo(),
      vendedor: Vendedor.nuevo(),
    );
  }
}
