import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';

import '../models/cliente.dart';

class ClienteRepository {
  final DioRestClient restClient;

  ClienteRepository(this.restClient);

  Future<RestClientResponse> findAll() async {
    return await restClient.get('/cliente/findAll');
  }

  Future<RestClientResponse> findByNombreODocumento(String condition) async {
    return await restClient.get(
      '/cliente/findByNombreODocumento',
      queryParameters: {"condition": condition},
    );
  }

  Future<RestClientResponse> saveCliente(Cliente cliente) async {
    return await restClient.post('/cliente/save', data: cliente.toJson());
  }

  Future<RestClientResponse> revisarExistenciaCi(String ciRuc) async {
    return await restClient.get('/cliente/revisarExistenciaCi',
        queryParameters: {"documento": ciRuc});
  }
}
