import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/cliente/pages/cliente_controller.dart';
import 'package:gestisoft_windows/app/modules/cliente/repositories/cliente_repository.dart';
import 'package:gestisoft_windows/app/modules/vendedor/pages/vendedor_controller.dart';
import 'package:gestisoft_windows/app/modules/vendedor/repositories/vendedor_repository.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/widgets/reporte_venta_page.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_controller.dart';
import 'package:gestisoft_windows/app/modules/venta/pages/venta_page.dart';
import 'package:gestisoft_windows/app/modules/venta/repositories/venta_repository.dart';

class VentaModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => ClienteRepository(i.get()),
        ),
        Bind.singleton(
          (i) => ClienteController(i.get()),
        ),
        Bind.singleton(
          (i) => VendedorRepository(i.get()),
        ),
        Bind.singleton(
          (i) => VendedorController(i.get()),
        ),
        Bind.singleton(
          (i) => VentaRepository(i.get()),
        ),
        Bind.singleton(
          (i) => VentaController(
            clienteRepository: i.get(),
            ventaRepository: i.get(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const VentaPage(),
        ),
        ChildRoute('/reporte',
            child: (context, args) => const ReporteVentaPage()),
      ];
}
