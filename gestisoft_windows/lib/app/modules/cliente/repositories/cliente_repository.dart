import 'package:dio/dio.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';

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
}
