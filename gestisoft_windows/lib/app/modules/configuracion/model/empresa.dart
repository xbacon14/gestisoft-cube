// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobx/mobx.dart';

class Empresa {
  int? id;
  @observable
  String? nombre;
  @observable
  String? ruc;
  @observable
  String? celular;
  @observable
  String? lineaBaja;
  @observable
  String? email;
  @observable
  String? ciudad;
  @observable
  String? direccion;
  @observable
  String? observacion;
  @observable
  bool? configuracionEfectuada;
  String? fechaRegistro;
  Empresa({
    required this.id,
    this.nombre,
    this.ruc,
    this.celular,
    this.lineaBaja,
    this.email,
    this.ciudad,
    this.direccion,
    this.observacion,
    this.configuracionEfectuada,
    this.fechaRegistro,
  });

  Empresa copyWith({
    int? id,
    String? nombre,
    String? ruc,
    String? celular,
    String? lineaBaja,
    String? email,
    String? ciudad,
    String? direccion,
    String? observacion,
  }) {
    return Empresa(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      ruc: ruc ?? this.ruc,
      celular: celular ?? this.celular,
      lineaBaja: lineaBaja ?? this.lineaBaja,
      email: email ?? this.email,
      ciudad: ciudad ?? this.ciudad,
      direccion: direccion ?? this.direccion,
      observacion: observacion ?? this.observacion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nombre': nombre,
      'ruc': ruc,
      'celular': celular,
      'lineaBaja': lineaBaja,
      'email': email,
      'ciudad': ciudad,
      'direccion': direccion,
      'observacion': observacion,
      'configuracionEfectuada': configuracionEfectuada,
      'fechaRegistro': fechaRegistro,
    };
  }

  factory Empresa.fromMap(Map<String, dynamic> map) {
    return Empresa(
      id: map['id'],
      nombre: map['nombre'] != null ? map['nombre'] : null,
      ruc: map['ruc'] != null ? map['ruc'] : null,
      celular: map['celular'] != null ? map['celular'] : null,
      lineaBaja: map['lineaBaja'] != null ? map['lineaBaja'] : null,
      email: map['email'] != null ? map['email'] : null,
      ciudad: map['ciudad'] != null ? map['ciudad'] : null,
      direccion: map['direccion'] != null ? map['direccion'] : null,
      observacion: map['observacion'] != null ? map['observacion'] : null,
      configuracionEfectuada: map['configuracionEfectuada'] ?? null,
      fechaRegistro: map['fechaRegistro'] ?? null,
    );
  }

  static Empresa nuevo() {
    return Empresa(
      id: null,
      nombre: "",
      ruc: "",
      configuracionEfectuada: true,
    );
  }

  @override
  String toString() {
    return 'Empresa(id: $id, nombre: $nombre, ruc: $ruc, celular: $celular, lineaBaja: $lineaBaja, email: $email, ciudad: $ciudad, direccion: $direccion, observacion: $observacion, configuracionEfectuada: $configuracionEfectuada)';
  }

  @override
  bool operator ==(covariant Empresa other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nombre == nombre &&
        other.ruc == ruc &&
        other.celular == celular &&
        other.lineaBaja == lineaBaja &&
        other.email == email &&
        other.ciudad == ciudad &&
        other.direccion == direccion &&
        other.observacion == observacion;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nombre.hashCode ^
        ruc.hashCode ^
        celular.hashCode ^
        lineaBaja.hashCode ^
        email.hashCode ^
        ciudad.hashCode ^
        direccion.hashCode ^
        observacion.hashCode;
  }
}
