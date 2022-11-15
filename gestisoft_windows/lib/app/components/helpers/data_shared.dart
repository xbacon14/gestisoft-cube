import 'package:mobx/mobx.dart';
part 'data_shared.g.dart';

class DataShared = DataSharedBase with _$DataShared;

abstract class DataSharedBase with Store {
  @observable
  String nombreEmpresa = "SIN DEFINIR";
  @observable
  String nombreUsuario = "USUARIO 1";
  @observable
  String version = "GESTISOFT v1.3 GUILLERMO CABALLERO - ITALO GOLIN";
}
