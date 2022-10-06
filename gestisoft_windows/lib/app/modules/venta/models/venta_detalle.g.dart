// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta_detalle.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VentaDetalle on VentaDetalleBase, Store {
  late final _$cantidadAtom =
      Atom(name: 'VentaDetalleBase.cantidad', context: context);

  @override
  double? get cantidad {
    _$cantidadAtom.reportRead();
    return super.cantidad;
  }

  @override
  set cantidad(double? value) {
    _$cantidadAtom.reportWrite(value, super.cantidad, () {
      super.cantidad = value;
    });
  }

  late final _$precioAtom =
      Atom(name: 'VentaDetalleBase.precio', context: context);

  @override
  double? get precio {
    _$precioAtom.reportRead();
    return super.precio;
  }

  @override
  set precio(double? value) {
    _$precioAtom.reportWrite(value, super.precio, () {
      super.precio = value;
    });
  }

  late final _$productoAtom =
      Atom(name: 'VentaDetalleBase.producto', context: context);

  @override
  Producto? get producto {
    _$productoAtom.reportRead();
    return super.producto;
  }

  @override
  set producto(Producto? value) {
    _$productoAtom.reportWrite(value, super.producto, () {
      super.producto = value;
    });
  }

  @override
  String toString() {
    return '''
cantidad: ${cantidad},
precio: ${precio},
producto: ${producto}
    ''';
  }
}
