import 'package:flutter_modular/flutter_modular.dart';
import './info_controller.dart';
import './info_page.dart';

class InfoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => InfoController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => InfoPage(),
    ),
  ];
}
