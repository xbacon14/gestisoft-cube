import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/cliente/cliente_module.dart';
import 'package:gestisoft_windows/app/modules/home/home_controller.dart';
import 'package:gestisoft_windows/app/modules/home/pages/home_page.dart';
import 'package:gestisoft_windows/app/modules/home/pages/widgets/home_view.dart';
import 'package:gestisoft_windows/app/modules/producto/pages/producto_controller.dart';
import 'package:gestisoft_windows/app/modules/producto/repositories/producto_repository.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProductoRepository(i.get())),
    Bind.lazySingleton((i) => ProductoController(i.get())),
    Bind.lazySingleton((i) => HomeController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const HomePage(), children: [
      ChildRoute('/home', child: (context, args) => const HomeView()),
      ModuleRoute('/cliente', module: ClienteModule()),
    ]),

    // ModuleRoute('/vendedor', module: HomeModule()),
    // ModuleRoute('/producto', module: HomeModule()),
    // ModuleRoute('/venta', module: HomeModule()),
    // ModuleRoute('/configuracion', module: HomeModule()),
  ];
}
