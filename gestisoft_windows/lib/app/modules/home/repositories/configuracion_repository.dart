import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';
import 'package:gestisoft_windows/app/modules/configuracion/model/empresa.dart';

class ConfiguracionRepository {
  final DioRestClient dioRestClient;
  ConfiguracionRepository(this.dioRestClient);

  Future<bool> verificarConexion() async {
    var conexao = false;
    await dioRestClient
        .get('/configuracion/verificar_conexion')
        .then((response) {
      if (response.statusCode == 200) {
        conexao = true;
      } else {
        conexao = false;
      }
    });

    return conexao;
  }

  Future<RestClientResponse> verificaConfiguracionEfectuada() async {
    return await dioRestClient.get('/configuracion/configuracion_efectuada');
    ;
  }

  Future<RestClientResponse> saveEmpresa(Empresa empresa) async {
    return await dioRestClient.post("/empresa/save", data: empresa.toMap());
  }

  Future<RestClientResponse> truncateTables() async {
    return await dioRestClient.put('/configuracion/truncate');
  }
}
