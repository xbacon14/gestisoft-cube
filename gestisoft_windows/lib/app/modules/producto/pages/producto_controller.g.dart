// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductoController on _ProductoControllerBase, Store {
  late final _$selectedAtom =
      Atom(name: '_ProductoControllerBase.selected', context: context);

  @override
  int get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(int value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  late final _$valuesAtom =
      Atom(name: '_ProductoControllerBase.values', context: context);

  @override
  List<String> get values {
    _$valuesAtom.reportRead();
    return super.values;
  }

  @override
  set values(List<String> value) {
    _$valuesAtom.reportWrite(value, super.values, () {
      super.values = value;
    });
  }

  late final _$currentRecordAtom =
      Atom(name: '_ProductoControllerBase.currentRecord', context: context);

  @override
  Producto get currentRecord {
    _$currentRecordAtom.reportRead();
    return super.currentRecord;
  }

  @override
  set currentRecord(Producto value) {
    _$currentRecordAtom.reportWrite(value, super.currentRecord, () {
      super.currentRecord = value;
    });
  }

  late final _$processandoAtom =
      Atom(name: '_ProductoControllerBase.processando', context: context);

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
      Atom(name: '_ProductoControllerBase.listaVacia', context: context);

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

  late final _$pdfAtom =
      Atom(name: '_ProductoControllerBase.pdf', context: context);

  @override
  Uint8List? get pdf {
    _$pdfAtom.reportRead();
    return super.pdf;
  }

  @override
  set pdf(Uint8List? value) {
    _$pdfAtom.reportWrite(value, super.pdf, () {
      super.pdf = value;
    });
  }

  late final _$pdfFileAtom =
      Atom(name: '_ProductoControllerBase.pdfFile', context: context);

  @override
  File get pdfFile {
    _$pdfFileAtom.reportRead();
    return super.pdfFile;
  }

  @override
  set pdfFile(File value) {
    _$pdfFileAtom.reportWrite(value, super.pdfFile, () {
      super.pdfFile = value;
    });
  }

  late final _$verInactivosAtom =
      Atom(name: '_ProductoControllerBase.verInactivos', context: context);

  @override
  bool get verInactivos {
    _$verInactivosAtom.reportRead();
    return super.verInactivos;
  }

  @override
  set verInactivos(bool value) {
    _$verInactivosAtom.reportWrite(value, super.verInactivos, () {
      super.verInactivos = value;
    });
  }

  @override
  String toString() {
    return '''
selected: ${selected},
values: ${values},
currentRecord: ${currentRecord},
processando: ${processando},
listaVacia: ${listaVacia},
pdf: ${pdf},
pdfFile: ${pdfFile},
verInactivos: ${verInactivos}
    ''';
  }
}
