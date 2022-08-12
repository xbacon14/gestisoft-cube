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

  @observable
  Vendedor currentRecord = Vendedor().nuevo();

  @observable
  bool processando = false;

  @observable
  bool listaVacia = false;

  @observable
  bool vendedorExiste = false;

  ObservableList<Vendedor> vendedores = ObservableList();

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

  Future<void> findByNombreODocumento(String condition) async {
    processando = true;
    final response = await vendedorRepository
        .findByNombreODocumento(condition)
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

  Future<void> saveVendedor() async {
    processando = true;

    final response = await vendedorRepository
        .saveVendedor(currentRecord)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      debugPrint(
          "El cliente ${currentRecord.nombre} ha sido guardado con exito");
      currentRecord = Vendedor().nuevo();
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

  resolveListaVacia() {
    if (vendedores.isEmpty) {
      listaVacia = true;
    } else {
      listaVacia = false;
    }
  }
}
