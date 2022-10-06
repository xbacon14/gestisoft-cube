import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/configuracion/pages/configuracion_controller.dart';
import 'package:gestisoft_windows/app/modules/configuracion/pages/configuracion_page.dart';

class ConfiguracionModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ConfiguracionController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => ConfiguracionPage(controller: Modular.get())),
  ];
}
