import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/repositories/venta_repository.dart';
import 'package:mobx/mobx.dart';

part 'venta_controller.g.dart';

class VentaController = _VentaControllerBase with _$VentaController;

abstract class _VentaControllerBase with Store {
  final VentaRepository ventaRepository;
  _VentaControllerBase(this.ventaRepository);

  @observable
  Venta currentRecord = Venta().nuevo();

  @action
  setCliente(Cliente cliente) => currentRecord.cliente = cliente;

  Future<void> getProximoCodigo() async {
    await ventaRepository.getProximoId().then((value) {
      currentRecord.id = value.data;
    });
  }
}
