import 'package:flutter/foundation.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/repositories/cliente_repository.dart';
import 'package:mobx/mobx.dart';
part 'cliente_controller.g.dart';

class ClienteController = ClienteControllerBase with _$ClienteController;

abstract class ClienteControllerBase with Store {
  final ClienteRepository clienteRepository;

  ClienteControllerBase(this.clienteRepository);

  @observable
  bool processando = false;

  @observable
  bool listaVacia = false;

  ObservableList<Cliente> clientes = ObservableList();

  Future<void> findAllClientes() async {
    processando = true;
    final response = await clienteRepository
        .findAll()
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      clientes.clear();
      clientes.addAll(
          response.data.map<Cliente>((c) => Cliente.fromMap(c)).toList());
      resolveListaVacia();
    } else {
      debugPrint("no se pudieron consultar los clientes");
    }
  }

  Future<void> findByNombreODocumento(String condition) async {
    processando = true;
    final response = await clienteRepository
        .findByNombreODocumento(condition)
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      clientes.clear();
      clientes.addAll(
          response.data.map<Cliente>((c) => Cliente.fromMap(c)).toList());
      resolveListaVacia();
    } else {
      debugPrint("no se pudieron consultar los clientes");
    }
  }

  resolveListaVacia() {
    if (clientes.isEmpty) {
      listaVacia = true;
    } else {
      listaVacia = false;
    }
  }
}
