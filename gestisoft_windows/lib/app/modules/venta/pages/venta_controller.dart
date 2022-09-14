import 'package:gestisoft_windows/app/modules/cliente/models/cliente.dart';
import 'package:gestisoft_windows/app/modules/cliente/repositories/cliente_repository.dart';
import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta.dart';
import 'package:gestisoft_windows/app/modules/venta/models/venta_detalle.dart';
import 'package:gestisoft_windows/app/modules/venta/repositories/venta_repository.dart';
import 'package:mobx/mobx.dart';

part 'venta_controller.g.dart';

class VentaController = _VentaControllerBase with _$VentaController;

abstract class _VentaControllerBase with Store {
  final VentaRepository ventaRepository;
  final ClienteRepository clienteRepository;
  _VentaControllerBase({
    required this.ventaRepository,
    required this.clienteRepository,
  });

  @observable
  bool listaVacia = false;
  @observable
  bool processando = false;

  @observable
  Venta currentRecord = Venta().nuevo();

  @observable
  Producto producto = Producto.nuevo();

  @action
  setCliente({required Cliente cliente}) {
    currentRecord.cliente = cliente;
  }

  @action
  setVendedor({required Vendedor vendedor}) async {
    currentRecord.vendedor = vendedor;
  }

  @action
  setProducto({required Producto producto}) async {
    producto = producto;
  }

  @action
  addItemProducto({required VentaDetalle item}) async {
    currentRecord.detalles!.add(item);
  }

  Future<void> getProximoCodigo() async {
    await ventaRepository.getProximoId().then((value) {
      currentRecord.id = value.data;
    });
  }
}
