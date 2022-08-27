import 'package:gestisoft_windows/app/components/core/rest_client/dio_rest_client.dart';
import 'package:gestisoft_windows/app/components/core/rest_client/rest_client_response.dart';
import 'package:gestisoft_windows/app/modules/vendedor/models/vendedor.dart';

class VendedorRepository {
  final DioRestClient restClient;

  VendedorRepository(this.restClient);

  Future<RestClientResponse> findAll() async {
    return await restClient.get('/vendedor/findAll');
  }

  Future<RestClientResponse> findByNombreODocumento(String condition) async {
    return await restClient.get(
      '/vendedor/findByNombreODocumento',
      queryParameters: {"condition": condition},
    );
  }

  Future<RestClientResponse> saveVendedor(Vendedor vendedor) async {
    return await restClient.post('/vendedor/save', data: vendedor.toJson());
  }

  Future<RestClientResponse> revisarExistenciaCi(String ci) async {
    return await restClient.get('/vendedor/revisarExistenciaCi',
        queryParameters: {"documento": ci});
  }

  Future<RestClientResponse> eliminarVendedorById(int idVendedor) async {
    return await restClient.delete('/vendedor/delete/$idVendedor');
  }
}
