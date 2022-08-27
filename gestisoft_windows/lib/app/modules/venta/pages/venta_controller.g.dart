// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venta_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VentaController on _VentaControllerBase, Store {
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

  late final _$_VentaControllerBaseActionController =
      ActionController(name: '_VentaControllerBase', context: context);

  @override
  dynamic setCliente(Cliente cliente) {
    final _$actionInfo = _$_VentaControllerBaseActionController.startAction(
        name: '_VentaControllerBase.setCliente');
    try {
      return super.setCliente(cliente);
    } finally {
      _$_VentaControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentRecord: ${currentRecord}
    ''';
  }
}
