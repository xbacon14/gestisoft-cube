import 'package:fluent_ui/fluent_ui.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/repositories/cliente_repository.dart';
import 'package:mobx/mobx.dart';
part 'cliente_controller.g.dart';

class ClienteController = ClienteControllerBase with _$ClienteController;

abstract class ClienteControllerBase with Store {
  final ClienteRepository clienteRepository;

  ClienteControllerBase(this.clienteRepository);

  @observable
  Cliente currentRecord = Cliente().nuevo();

  @observable
  bool processando = false;

  @observable
  bool listaVacia = false;

  @observable
  bool clienteExiste = false;

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

  Future<List<Cliente>> findByNombreODocumento(String condition) async {
    processando = true;
    List<Cliente> lista = [];
    final response = await clienteRepository
        .findByNombreODocumento(condition)
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      clientes.clear();
      clientes.addAll(
          response.data.map<Cliente>((c) => Cliente.fromMap(c)).toList());
      lista = clientes;
      resolveListaVacia();
    } else {
      debugPrint("no se pudieron consultar los clientes");
    }
    return lista;
  }

  Future<void> saveCliente() async {
    processando = true;

    final response = await clienteRepository
        .saveCliente(currentRecord)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      debugPrint(
          "El cliente ${currentRecord.nombre} ha sido guardado con exito");
      currentRecord = Cliente().nuevo();
    } else {
      debugPrint("No se ha podido guardar el cliente");
    }
  }

  Future<bool> revisarExistenciaCi(String ci) async {
    processando = true;
    final response = await clienteRepository
        .revisarExistenciaCi(ci)
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      clienteExiste = response.data;
      return response.data;
    } else {
      debugPrint("No se ha podido consultar el ci");
      return false;
    }
  }

  Future<void> eliminaClienteById(BuildContext context, int idCliente) async {
    processando = true;
    final response = await clienteRepository
        .eliminarClienteById(idCliente)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      String message = response.data;
      if (message.startsWith("Cliente")) {
        Alert.show(context: context, message: message, type: 0);
      } else {
        Alert.show(context: context, message: message, type: 2);
      }
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
