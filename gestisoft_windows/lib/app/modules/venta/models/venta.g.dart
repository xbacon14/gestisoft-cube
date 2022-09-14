// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Venta on VentaBase, Store {
  late final _$idAtom = Atom(name: 'VentaBase.id', context: context);

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$vendedorAtom =
      Atom(name: 'VentaBase.vendedor', context: context);

  @override
  Vendedor? get vendedor {
    _$vendedorAtom.reportRead();
    return super.vendedor;
  }

  @override
  set vendedor(Vendedor? value) {
    _$vendedorAtom.reportWrite(value, super.vendedor, () {
      super.vendedor = value;
    });
  }

  late final _$clienteAtom = Atom(name: 'VentaBase.cliente', context: context);

  @override
  Cliente? get cliente {
    _$clienteAtom.reportRead();
    return super.cliente;
  }

  @override
  set cliente(Cliente? value) {
    _$clienteAtom.reportWrite(value, super.cliente, () {
      super.cliente = value;
    });
  }

  @override
  String toString() {
    return '''
id: ${id},
vendedor: ${vendedor},
cliente: ${cliente}
    ''';
  }
}
