// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendedor_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$VendedorController on _VendedorControllerBase, Store {
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

  late final _$pdfAtom =
      Atom(name: '_VendedorControllerBase.pdf', context: context);

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
      Atom(name: '_VendedorControllerBase.pdfFile', context: context);

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
      Atom(name: '_VendedorControllerBase.verInactivos', context: context);

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
processando: ${processando},
listaVacia: ${listaVacia},
vendedorExiste: ${vendedorExiste},
pdf: ${pdf},
pdfFile: ${pdfFile},
verInactivos: ${verInactivos}
    ''';
  }
}
