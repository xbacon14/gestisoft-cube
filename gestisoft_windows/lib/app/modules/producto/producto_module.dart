import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_page.dart';
import 'package:gestisoft_windows/app/modules/producto/repositories/producto_repository.dart';

class ProductoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => ProductoRepository(i.get()),
        ),
        Bind.singleton(
          (i) => ProductoController(i.get()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const ProductoPage()),
      ];
}
