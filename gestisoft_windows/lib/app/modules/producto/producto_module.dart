import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_page.dart';

class ProductoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProductoController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => ProductoPage(controller: Modular.get())),
  ];
}
