// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_shared.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DataShared on DataSharedBase, Store {
  late final _$nombreEmpresaAtom =
      Atom(name: 'DataSharedBase.nombreEmpresa', context: context);

  @override
  String get nombreEmpresa {
    _$nombreEmpresaAtom.reportRead();
    return super.nombreEmpresa;
  }

  @override
  set nombreEmpresa(String value) {
    _$nombreEmpresaAtom.reportWrite(value, super.nombreEmpresa, () {
      super.nombreEmpresa = value;
    });
  }

  late final _$nombreUsuarioAtom =
      Atom(name: 'DataSharedBase.nombreUsuario', context: context);

  @override
  String get nombreUsuario {
    _$nombreUsuarioAtom.reportRead();
    return super.nombreUsuario;
  }

  @override
  set nombreUsuario(String value) {
    _$nombreUsuarioAtom.reportWrite(value, super.nombreUsuario, () {
      super.nombreUsuario = value;
    });
  }

  @override
  String toString() {
    return '''
nombreEmpresa: ${nombreEmpresa},
nombreUsuario: ${nombreUsuario}
    ''';
  }
}
