// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VentaController on _VentaControllerBase, Store {
  late final _$listaVaciaAtom =
      Atom(name: '_VentaControllerBase.listaVacia', context: context);

  @override
  bool get listaVacia {
    _$listaVaciaAtom.reportRead();
    return super.listaVacia;
  }

  @override
  set listaVacia(bool value) {
    _$listaVaciaAtom.reportWrite(value, super.listaVacia, () {
      super.listaVacia = value;
    });
  }

  late final _$processandoAtom =
      Atom(name: '_VentaControllerBase.processando', context: context);

  @override
  bool get processando {
    _$processandoAtom.reportRead();
    return super.processando;
  }

  @override
  set processando(bool value) {
    _$processandoAtom.reportWrite(value, super.processando, () {
      super.processando = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: '_VentaControllerBase.currentRecord', context: context);

  @override
  Venta get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Venta value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$productoAtom =
      Atom(name: '_VentaControllerBase.producto', context: context);

  @override
  Producto get producto {
    _$productoAtom.reportRead();
    return super.producto;
  }

  @override
  set producto(Producto value) {
    _$productoAtom.reportWrite(value, super.producto, () {
      super.producto = value;
    });
  }

  late final _$setVendedorAsyncAction =
      AsyncAction('_VentaControllerBase.setVendedor', context: context);

  @override
  Future setVendedor({required Vendedor vendedor}) {
    return _$setVendedorAsyncAction
        .run(() => super.setVendedor(vendedor: vendedor));
  }

  late final _$setProductoAsyncAction =
      AsyncAction('_VentaControllerBase.setProducto', context: context);

  @override
  Future setProducto({required Producto producto}) {
    return _$setProductoAsyncAction
        .run(() => super.setProducto(producto: producto));
  }

  late final _$addItemProductoAsyncAction =
      AsyncAction('_VentaControllerBase.addItemProducto', context: context);

  @override
  Future addItemProducto({required VentaDetalle item}) {
    return _$addItemProductoAsyncAction
        .run(() => super.addItemProducto(item: item));
  }

  late final _$_VentaControllerBaseActionController =
      ActionController(name: '_VentaControllerBase', context: context);

  @override
  dynamic setCliente({required Cliente cliente}) {
    final _$actionInfo = _$_VentaControllerBaseActionController.startAction(
        name: '_VentaControllerBase.setCliente');
    try {
      return super.setCliente(cliente: cliente);
    } finally {
      _$_VentaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaVacia: ${listaVacia},
processando: ${processando},
currentRecord: ${currentRecord},
producto: ${producto}
    ''';
  }
}
