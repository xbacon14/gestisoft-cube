import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/modules/home/repositories/configuracion_repository.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final ConfiguracionRepository configuracionRepository = Modular.get();

  @observable
  bool online = false;

  Future<bool> verificarConexion() async {
    online = await configuracionRepository.verificarConexion();
    if (online) {
      Modular.to.pushNamed('/home');
      return online;
    }
    return online;
  }
}
