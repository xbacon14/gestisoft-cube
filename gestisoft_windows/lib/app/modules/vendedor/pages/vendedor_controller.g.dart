// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendedor_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VendedorController on _VendedorControllerBase, Store {
  late final _$currentRecordAtom =
      Atom(name: '_VendedorControllerBase.currentRecord', context: context);

  @override
  Vendedor get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Vendedor value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$processandoAtom =
      Atom(name: '_VendedorControllerBase.processando', context: context);

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
      Atom(name: '_VendedorControllerBase.listaVacia', context: context);

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

  late final _$vendedorExisteAtom =
      Atom(name: '_VendedorControllerBase.vendedorExiste', context: context);

  @override
  bool get vendedorExiste {
    _$vendedorExisteAtom.reportRead();
    return super.vendedorExiste;
  }

  @override
  set vendedorExiste(bool value) {
    _$vendedorExisteAtom.reportWrite(value, super.vendedorExiste, () {
      super.vendedorExiste = value;
    });
  }

  @override
  String toString() {
    return '''
currentRecord: ${currentRecord},
processando: ${processando},
listaVacia: ${listaVacia},
vendedorExiste: ${vendedorExiste}
    ''';
  }
}
