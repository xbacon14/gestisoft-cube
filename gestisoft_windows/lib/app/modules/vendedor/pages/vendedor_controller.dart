import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/vendedor/repositories/vendedor_repository.dart';
import 'package:mobx/mobx.dart';

part 'vendedor_controller.g.dart';

class VendedorController = _VendedorControllerBase with _$VendedorController;

abstract class _VendedorControllerBase with Store {
  final VendedorRepository vendedorRepository;

  _VendedorControllerBase(this.vendedorRepository);

  Vendedor currentRecord = Vendedor.nuevo();

  @observable
  bool processando = false;

  @observable
  bool listaVacia = false;

  @observable
  bool vendedorExiste = false;

  ObservableList<Vendedor> vendedores = ObservableList();

  // REPORTE
  @observable
  Uint8List? pdf;

  @observable
  File pdfFile = File('');

  @observable
  bool verInactivos = false;

  Future<void> findAllVendedores() async {
    processando = true;
    final response = await vendedorRepository
        .findAll()
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      vendedores.clear();
      vendedores.addAll(
          response.data.map<Vendedor>((c) => Vendedor.fromJson(c)).toList());
      resolveListaVacia();
    } else {
      debugPrint("no se pudieron consultar los vendedores");
    }
  }

  Future<List<Vendedor>> findByNombreODocumento(String condition) async {
    processando = true;
    List<Vendedor> lista = [];
    final response = await vendedorRepository
        .findByNombreODocumento(condition)
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      lista.addAll(
          response.data.map<Vendedor>((c) => Vendedor.fromJson(c)).toList());
      vendedores.clear();

      vendedores.addAll(lista);
      resolveListaVacia();
    } else {
      debugPrint("no se pudieron consultar los vendedores");
    }
    return lista;
  }

  Future<void> saveVendedor() async {
    processando = true;

    final response = await vendedorRepository
        .saveVendedor(currentRecord)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      debugPrint(
          "El cliente ${currentRecord.nombre} ha sido guardado con exito");
      currentRecord = Vendedor.nuevo();
    } else {
      debugPrint("No se ha podido guardar el cliente");
    }
  }

  Future<bool> revisarExistenciaCi(String ci) async {
    processando = true;
    final response = await vendedorRepository
        .revisarExistenciaCi(ci)
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      vendedorExiste = response.data;
      return response.data;
    } else {
      debugPrint("No se ha podido consultar el ci");
      return false;
    }
  }

  Future<void> eliminaVendedorById(BuildContext context, int idVendedor) async {
    processando = true;
    final response = await vendedorRepository
        .eliminarVendedorById(idVendedor)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      String message = response.data;
      if (message.startsWith("Vendedor")) {
        Alert.show(context: context, message: message, type: 0);
      } else {
        Alert.show(context: context, message: message, type: 2);
      }
    }
  }

  Future<Uint8List> geraRelatorio({
    required BuildContext context,
    String? filtroDesde,
    String? filtroHasta,
    String? orderBy,
    required bool isPdf,
  }) async {
    processando = true;
    final response = await vendedorRepository
        .geraRelatorio(
            filtroDesde: filtroDesde,
            filtroHasta: filtroHasta,
            orderBy: orderBy,
            verInactivos: verInactivos,
            isPdf: isPdf)
        .whenComplete(() => processando = false);
    if (response.compareTo('error') == 0) {
      Alert.show(
          context: context,
          message: "Error, no se pudo generar el reporte",
          type: 2);
      throw Error();
    } else {}
    return base64.decode(response);
  }

  resolveListaVacia() {
    if (vendedores.isEmpty) {
      listaVacia = true;
    } else {
      listaVacia = false;
    }
  }
}
