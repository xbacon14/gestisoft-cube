import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_page.dart';
import 'package:gestisoft_windows/app/modules/vendedor/repositories/vendedor_repository.dart';

class VendedorModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => VendedorRepository(i.get())),
        Bind.singleton((i) => VendedorController(i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => const VendedorPage(),
        ),
      ];
}
