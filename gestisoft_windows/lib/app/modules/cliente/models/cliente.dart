// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cliente {
  int? id;
  bool? estado;
  String? nombre;
  String? ciRuc;
  String? email;
  String? celular;
  String? lineaBaja;
  String? direccion;
  String? observacion;
  String? fechaAlta;
  Cliente({
    this.id,
    this.estado,
    this.nombre,
    this.ciRuc,
    this.email,
    this.celular,
    this.lineaBaja,
    this.direccion,
    this.observacion,
    this.fechaAlta,
  });

  Cliente copyWith({
    int? id,
    bool? estado,
    String? nombre,
    String? ciRuc,
    String? email,
    String? celular,
    String? lineaBaja,
    String? direccion,
    String? observacion,
    String? fechaAlta,
  }) {
    return Cliente(
      id: id ?? this.id,
      estado: estado ?? this.estado,
      nombre: nombre ?? this.nombre,
      ciRuc: ciRuc ?? this.ciRuc,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      lineaBaja: lineaBaja ?? this.lineaBaja,
      direccion: direccion ?? this.direccion,
      observacion: observacion ?? this.observacion,
      fechaAlta: fechaAlta ?? this.fechaAlta,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'estado': estado,
      'nombre': nombre,
      'ciRuc': ciRuc,
      'email': email,
      'celular': celular,
      'lineaBaja': lineaBaja,
      'direccion': direccion,
      'observacion': observacion,
      'fechaAlta': fechaAlta,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] != null ? map['id'] as int : null,
      estado: map['estado'] != null ? map['estado'] as bool : null,
      nombre: map['nombre'] != null ? map['nombre'] as String : null,
      ciRuc: map['ciRuc'] != null ? map['ciRuc'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      celular: map['celular'] != null ? map['celular'] as String : null,
      lineaBaja: map['lineaBaja'] != null ? map['lineaBaja'] as String : null,
      direccion: map['direccion'] != null ? map['direccion'] as String : null,
      observacion:
          map['observacion'] != null ? map['observacion'] as String : null,
      fechaAlta: map['fechaAlta'] != null ? map['fechaAlta'] as String : null,
    );
  }

  Cliente nuevo() {
    return Cliente(
      id: null,
      nombre: "",
      ciRuc: "",
      email: "",
      fechaAlta: "",
      celular: "",
      lineaBaja: "",
      direccion: "",
      observacion: "",
      estado: true,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cliente.fromJson(String source) =>
      Cliente.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cliente(id: $id, estado: $estado, nombre: $nombre, ciRuc: $ciRuc, email: $email, celular: $celular, lineaBaja: $lineaBaja, direccion: $direccion, observacion: $observacion, fechaAlta: $fechaAlta)';
  }

  @override
  bool operator ==(covariant Cliente other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.estado == estado &&
        other.nombre == nombre &&
        other.ciRuc == ciRuc &&
        other.email == email &&
        other.celular == celular &&
        other.lineaBaja == lineaBaja &&
        other.direccion == direccion &&
        other.observacion == observacion &&
        other.fechaAlta == fechaAlta;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        estado.hashCode ^
        nombre.hashCode ^
        ciRuc.hashCode ^
        email.hashCode ^
        celular.hashCode ^
        lineaBaja.hashCode ^
        direccion.hashCode ^
        observacion.hashCode ^
        fechaAlta.hashCode;
  }
}
