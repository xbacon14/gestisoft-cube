class Vendedor {
  int? id;
  bool? estado;
  String? nombre;
  String? ci;
  String? celular;
  String? lineaBaja;
  String? ciudad;
  String? direccion;
  String? observacion;
  String? fechaAlta;

  Vendedor(
      {id,
      estado,
      nombre,
      ci,
      celular,
      lineaBaja,
      ciudad,
      direccion,
      observacion,
      fechaAlta});

  Vendedor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estado = json['estado'];
    nombre = json['nombre'];
    ci = json['ci'];
    celular = json['celular'];
    lineaBaja = json['lineaBaja'];
    ciudad = json['ciudad'];
    direccion = json['direccion'];
    observacion = json['observacion'];
    fechaAlta = json['fechaAlta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['estado'] = estado;
    data['nombre'] = nombre;
    data['ci'] = ci;
    data['celular'] = celular;
    data['lineaBaja'] = lineaBaja;
    data['ciudad'] = ciudad;
    data['direccion'] = direccion;
    data['observacion'] = observacion;
    data['fechaAlta'] = fechaAlta;
    return data;
  }

  Vendedor nuevo() {
    return Vendedor(
      id: null,
      nombre: "",
      estado: true,
    );
  }
}
