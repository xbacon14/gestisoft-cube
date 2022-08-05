import 'package:gestisoft_windows/app/modules/producto/models/producto.dart';
import 'package:gestisoft_windows/app/modules/producto/repositories/producto_repository.dart';
import 'package:mobx/mobx.dart';

part 'producto_controller.g.dart';

class ProductoController = _ProductoControllerBase with _$ProductoController;

abstract class _ProductoControllerBase with Store {
  final ProductoRepository productoRepository;
  _ProductoControllerBase(this.productoRepository);

  @observable
  bool processando = false;

  ObservableList<Producto> dataProvider = ObservableList();

  Future<void> findAllProductos() async {
    processando = true;
    final response = await productoRepository
        .findAllProductos()
        .whenComplete(() => processando = false);
    if (response.statusCode == 200) {
      dataProvider.clear();
      dataProvider.addAll(
          response.data.map<Producto>((p) => Producto.fromJson(p)).toList());
    }
  }
}
