// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracion_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfiguracionController on _ConfiguracionControllerBase, Store {
  late final _$currentRecordAtom = Atom(
      name: '_ConfiguracionControllerBase.currentRecord', context: context);

  @override
  Empresa? get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Empresa? value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$procesandoAtom =
      Atom(name: '_ConfiguracionControllerBase.procesando', context: context);

  @override
  bool get procesando {
    _$procesandoAtom.reportRead();
    return super.procesando;
  }

  @override
  set procesando(bool value) {
    _$procesandoAtom.reportWrite(value, super.procesando, () {
      super.procesando = value;
    });
  }

  late final _$editarCamposAtom =
      Atom(name: '_ConfiguracionControllerBase.editarCampos', context: context);

  @override
  bool get editarCampos {
    _$editarCamposAtom.reportRead();
    return super.editarCampos;
  }

  @override
  set editarCampos(bool value) {
    _$editarCamposAtom.reportWrite(value, super.editarCampos, () {
      super.editarCampos = value;
    });
  }

  late final _$saveAsyncAction =
      AsyncAction('_ConfiguracionControllerBase.save', context: context);

  @override
  Future<Empresa> save(BuildContext context) {
    return _$saveAsyncAction.run(() => super.save(context));
  }

  late final _$truncateTablesAsyncAction = AsyncAction(
      '_ConfiguracionControllerBase.truncateTables',
      context: context);

  @override
  Future<bool> truncateTables(BuildContext context) {
    return _$truncateTablesAsyncAction.run(() => super.truncateTables(context));
  }

  late final _$_ConfiguracionControllerBaseActionController =
      ActionController(name: '_ConfiguracionControllerBase', context: context);

  @override
  void limpiarCampos() {
    final _$actionInfo = _$_ConfiguracionControllerBaseActionController
        .startAction(name: '_ConfiguracionControllerBase.limpiarCampos');
    try {
      return super.limpiarCampos();
    } finally {
      _$_ConfiguracionControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentRecord: ${currentRecord},
procesando: ${procesando},
editarCampos: ${editarCampos}
    ''';
  }
}
