import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_page.dart';
import 'package:gestisoft_windows/app/modules/cliente/repositories/cliente_repository.dart';

class ClienteModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => ClienteRepository(i.get()),
        ),
        Bind.singleton(
          (i) => ClienteController(i.get()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const ClientePage(),
        ),
      ];
}
