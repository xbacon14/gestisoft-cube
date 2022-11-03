import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/helpers/data_shared.dart';
import 'package:gestisoft_windows/app/modules/configuracion/pages/configuracion_controller.dart';
import 'package:gestisoft_windows/app/modules/home/home_module.dart';
import 'package:gestisoft_windows/app/modules/home/repositories/configuracion_repository.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => DioRestClient(),
        ),
        Bind.singleton(
          (i) => DataShared(),
        ),
        Bind.singleton(
          (i) => ConfiguracionRepository(i.get()),
        ),

        Bind.singleton(
          (i) => ConfiguracionController(
            configuracionRepository: i.get(),
          ),
        ),
        // Bind.singleton(
        //   (i) => ThemeShared(),
        // ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: HomeModule(),
        ),
      ];
}
