// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Producto on ProductoBase, Store {
  late final _$nombreAtom = Atom(name: 'ProductoBase.nombre', context: context);

  @override
  String? get nombre {
    _$nombreAtom.reportRead();
    return super.nombre;
  }

  @override
  set nombre(String? value) {
    _$nombreAtom.reportWrite(value, super.nombre, () {
      super.nombre = value;
    });
  }

  @override
  String toString() {
    return '''
nombre: ${nombre}
    ''';
  }
}
