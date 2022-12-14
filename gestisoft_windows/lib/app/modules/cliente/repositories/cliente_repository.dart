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

  Future<RestClientResponse> eliminarClienteById(int idCliente) async {
    return await restClient.delete('/cliente/deleteCliente/$idCliente');
  }

  Future<String> geraRelatorio({
    String? filtroDesde,
    String? filtroHasta,
    String? orderBy,
    required bool verInactivos,
    required bool isPdf,
  }) async {
    final response =
        await restClient.get("/cliente/generaReporte", queryParameters: {
      "filtroDesde": filtroDesde,
      "filtroHasta": filtroHasta,
      "orderByCondition": orderBy,
      "verInactivos": verInactivos,
      "verPdf": isPdf,
    });
    return response.data['body'];
  }
}
