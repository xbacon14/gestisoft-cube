import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gestisoft_windows/app/components/ui/alert.dart';
import 'package:gestisoft_windows/app/modules/configuracion/model/empresa.dart';
import 'package:gestisoft_windows/app/modules/home/repositories/configuracion_repository.dart';
import 'package:mobx/mobx.dart';

part 'configuracion_controller.g.dart';

class ConfiguracionController = _ConfiguracionControllerBase
    with _$ConfiguracionController;

abstract class _ConfiguracionControllerBase with Store {
  _ConfiguracionControllerBase({required this.configuracionRepository});

  final ConfiguracionRepository configuracionRepository;

  @observable
  Empresa? currentRecord = Empresa.nuevo();

  @observable
  bool procesando = false;

  @observable
  bool editarCampos = false;

  @action
  Future<Empresa> save(BuildContext context) async {
    procesando = true;
    Empresa e = Empresa.nuevo();
    final response = await configuracionRepository
        .saveEmpresa(currentRecord!)
        .whenComplete(() => procesando = false);
    e = Empresa.fromMap(response.data);
    if (response.statusCode == 200) {
      currentRecord = e;

      editarCampos = false;
      Alert.show(
          context: context,
          message: "La empresa ${e.nombre} ha sido guardado con exito",
          type: 0);
      debugPrint("La empresa ${e.nombre} ha sido guardado con exito");
    } else {
      debugPrint("No se ha podido guardar la empresa");
      Alert.show(
          context: context,
          message: "No se ha guardar los datos de la empresa",
          type: 2);
    }
    return e;
  }

  @action
  Future<bool> truncateTables(BuildContext context) async {
    procesando = true;
    bool result = false;
    final response =
        await configuracionRepository.truncateTables().whenComplete(() {
      procesando = false;
      Modular.to.pushNamed('/configuracion/');
    });
    if (response.statusCode == 200) {
      limpiarCampos();
      editarCampos = true;
      currentRecord!.configuracionEfectuada = false;
      result = response.data;
      Alert.show(
          context: context,
          message: "La base de datos fue límpia con exito",
          type: 0);
    } else {
      Alert.show(
          context: context,
          message: "No se ha podido limpiar la base",
          type: 2);
    }
    return result;
  }

  Future<Empresa> verificaConfiguracionEfectuada() async {
    final response =
        await configuracionRepository.verificaConfiguracionEfectuada();
    Empresa e = currentRecord!;
    if (response.data == null || response.data == "") {
      e.configuracionEfectuada = false;
      editarCampos = true;
      return e;
    } else if (response.statusCode == 200) {
      if (e.configuracionEfectuada!) {
        e = currentRecord = Empresa.fromMap(response.data);
      }
    } else {
      debugPrint("No se ha podido consultar la configuracion de la empresa");
    }

    return e;
  }

  @action
  void limpiarCampos() {
    currentRecord = Empresa.nuevo();
  }
}
