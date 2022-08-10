// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClienteController on ClienteControllerBase, Store {
  late final _$currentRecordAtom =
      Atom(name: 'ClienteControllerBase.currentRecord', context: context);

  @override
  Cliente get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Cliente value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$processandoAtom =
      Atom(name: 'ClienteControllerBase.processando', context: context);

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

  late final _$listaVaciaAtom =
      Atom(name: 'ClienteControllerBase.listaVacia', context: context);

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

  late final _$clienteExisteAtom =
      Atom(name: 'ClienteControllerBase.clienteExiste', context: context);

  @override
  bool get clienteExiste {
    _$clienteExisteAtom.reportRead();
    return super.clienteExiste;
  }

  @override
  set clienteExiste(bool value) {
    _$clienteExisteAtom.reportWrite(value, super.clienteExiste, () {
      super.clienteExiste = value;
    });
  }

  @override
  String toString() {
    return '''
currentRecord: ${currentRecord},
processando: ${processando},
listaVacia: ${listaVacia},
clienteExiste: ${clienteExiste}
    ''';
  }
}
