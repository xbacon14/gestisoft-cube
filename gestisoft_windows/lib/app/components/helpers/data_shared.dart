import 'package:mobx/mobx.dart';
part 'data_shared.g.dart';

class DataShared = DataSharedBase with _$DataShared;

abstract class DataSharedBase with Store {
  @observable
  String nombreEmpresa = "J.P. MORGAN DISTRIBUIDORA";
  @observable
  String nombreUsuario = "USUARIO 1";
}
